import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';

import '../utils/getAppCurrentVersion.dart';
import 'cache_keys.dart';

// Custom exception for cache-related errors
class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

// Data structure for expiration metadata
class CacheEntry {
  final String value;
  final DateTime? expiry;

  CacheEntry(this.value, {this.expiry});

  Map<String, dynamic> toJson() => {
    'value': value,
    'expiry': expiry?.toIso8601String(),
  };

  static CacheEntry? fromJson(String json) {
    try {
      final map = jsonDecode(json);
      final value = map['value'] as String;
      final expiryStr = map['expiry'] as String?;
      final expiry = expiryStr != null ? DateTime.tryParse(expiryStr) : null;
      return CacheEntry(value, expiry: expiry);
    } catch (e) {
      return null;
    }
  }
}

class CacheHelper {
  static SharedPreferences? _preferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  static final Logger _logger = Logger('CacheHelper');
  static bool _isInitialized = false;
  
  static String ? currentToken =""; 
  static String ? currenAppVersion = "1.0.0";

  // Initialize logging
  static void _setupLogging() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  /// Initialize SharedPreferences and logging
  static Future<void> init() async {
    if (!_isInitialized) {
      _setupLogging();
      _preferences = await SharedPreferences.getInstance();
      _isInitialized = true;
      _logger.info('CacheHelper initialized');
      
      currentToken = await getUserToken();
     
      currenAppVersion =  /*"3.2.1"*/ await  VersionHelper.getCurrentAppVersion();
      
      await _cleanExpiredEntries();
    }
  }
  static Future<String ?> getUserToken() async {
    try {
      final currentToken = await CacheHelper.getData(
        PrefKeys.accessToken,
        isSensitive: true,
      );
     return currentToken ;
    } catch (error) {
      print('Error getting user token: $error');
      return "" ; 
    }
  }

  
  
  /// Save string data with optional expiration
  static Future<bool> saveData({
    required String key,
    required String value,
    int? expirySeconds,
    bool isSensitive = false,
  }) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        await _secureStorage.write(
          key: key,
          value: value,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        );
        _logger.info('Saved sensitive data for key: $key');
        return true;
      } else {
        final entry = CacheEntry(
          value,
          expiry: expirySeconds != null
              ? DateTime.now().add(Duration(seconds: expirySeconds))
              : null,
        );
        final encodedEntry = jsonEncode(entry.toJson());
        final result = await _preferences!.setString(key, encodedEntry);
        _logger.info('Saved data for key: $key, expires: ${entry.expiry}');
        await _manageCacheSize();
        return result;
      }
    } catch (e) {
      _logger.severe('Failed to save data for key: $key, error: $e');
      throw CacheException('Failed to save data for key: $key, error: $e');
    }
  }

  /// Retrieve string data
  static Future<String?> getData(String key, {bool isSensitive = false}) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        final value = await _secureStorage.read(
          key: key,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        );
        if (value == null) {
          _logger.warning('No sensitive data found for key: $key');
          return null;
        }
        return value;
      } else {
        final encodedEntry = _preferences!.getString(key);
        if (encodedEntry == null) {
          _logger.warning('No data found for key: $key');
          return null;
        }

        final entry = CacheEntry.fromJson(encodedEntry);
        if (entry == null) {
          _logger.warning('Invalid cache entry for key: $key');
          await removeData(key);
          return null;
        }

        if (entry.expiry != null && entry.expiry!.isBefore(DateTime.now())) {
          _logger.info('Cache entry expired for key: $key');
          await removeData(key);
          return null;
        }

        return entry.value;
      }
    } catch (e) {
      _logger.severe('Failed to retrieve data for key: $key, error: $e');
      throw CacheException('Failed to retrieve data for key: $key, error: $e');
    }
  }

  /// Remove specific key
  static Future<bool> removeData(String key, {bool isSensitive = false}) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        await _secureStorage.delete(
          key: key,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        );
        _logger.info('Removed sensitive data for key: $key');
        return true;
      } else {
        final result = await _preferences!.remove(key);
        _logger.info('Removed data for key: $key');
        return result;
      }
    } catch (e) {
      _logger.severe('Failed to remove data for key: $key, error: $e');
      throw CacheException('Failed to remove data for key: $key, error: $e');
    }
  }

  /// Clear all data
  static Future<bool> clearAll({bool includeSensitive = false}) async {
    await _ensureInitialized();
    try {
      final result = await _preferences!.clear();
      if (includeSensitive) {
        await _secureStorage.deleteAll(
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        );
        _logger.info('Cleared all sensitive data');
      }
      _logger.info('Cleared all SharedPreferences data');
      return result;
    } catch (e) {
      _logger.severe('Failed to clear cache, error: $e');
      throw CacheException('Failed to clear cache, error: $e');
    }
  }

  /// Check if key exists
  static Future<bool> containsKey(String key, {bool isSensitive = false}) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        final value = await _secureStorage.read(
          key: key,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        );
        return value != null;
      } else {
        return _preferences!.containsKey(key);
      }
    } catch (e) {
      _logger.severe('Failed to check key: $key, error: $e');
      throw CacheException('Failed to check key: $key, error: $e');
    }
  }

  /// Batch save multiple key-value pairs
  static Future<bool> saveBatch(Map<String, String> data,
      {int? expirySeconds, bool isSensitive = false}) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        await Future.wait(data.entries.map((entry) => _secureStorage.write(
          key: entry.key,
          value: entry.value,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        )));
        _logger.info('Batch saved ${data.length} sensitive items');
      } else {
        final entries = data.map((key, value) => MapEntry(
          key,
          jsonEncode(CacheEntry(
            value,
            expiry: expirySeconds != null
                ? DateTime.now().add(Duration(seconds: expirySeconds))
                : null,
          ).toJson()),
        ));
        await Future.wait(entries.entries.map((entry) =>
            _preferences!.setString(entry.key, entry.value)));
        _logger.info('Batch saved ${data.length} items');
        await _manageCacheSize();
      }
      return true;
    } catch (e) {
      _logger.severe('Failed to batch save, error: $e');
      throw CacheException('Failed to batch save, error: $e');
    }
  }

  /// Batch remove multiple keys
  static Future<bool> removeBatch(List<String> keys,
      {bool isSensitive = false}) async {
    await _ensureInitialized();
    try {
      if (isSensitive) {
        await Future.wait(keys.map((key) => _secureStorage.delete(
          key: key,
          iOptions: _getDefaultIOSOptions(),
          aOptions: _getDefaultAndroidOptions(),
        )));
      } else {
        await Future.wait(keys.map((key) => _preferences!.remove(key)));
      }
      _logger.info('Batch removed ${keys.length} items');
      return true;
    } catch (e) {
      _logger.severe('Failed to batch remove, error: $e');
      throw CacheException('Failed to batch remove, error: $e');
    }
  }

  /// Clean expired entries
  static Future<void> _cleanExpiredEntries() async {
    await _ensureInitialized();
    try {
      final keys = _preferences!.getKeys();
      await Future.wait(keys.map((key) async {
        final encodedEntry = _preferences!.getString(key);
        if (encodedEntry != null) {
          final entry = CacheEntry.fromJson(encodedEntry);
          if (entry != null && entry.expiry != null && entry.expiry!.isBefore(DateTime.now())) {
            await removeData(key);
          }
        }
      }));
      _logger.info('Cleaned expired cache entries');
    } catch (e) {
      _logger.severe('Failed to clean expired entries, error: $e');
    }
  }

  /// Manage cache size (limit to ~10MB)
  static Future<void> _manageCacheSize() async {
    try {
      final keys = _preferences!.getKeys().toList();
      int totalSize = 0;
      const maxSize = 10 * 1024 * 1024; // 10MB

      // Calculate total size
      for (var key in keys) {
        final value = _preferences!.getString(key);
        if (value != null) {
          totalSize += value.length;
        }
      }

      // Remove oldest entries if size exceeds limit
      if (totalSize > maxSize) {
        _logger.warning('Cache size exceeded limit, clearing oldest entries');
        keys.sort((a, b) => a.compareTo(b)); // FIFO sorting
        for (var key in keys) {
          final value = _preferences!.getString(key);
          if (value != null) {
            await removeData(key);
            totalSize -= value.length;
            if (totalSize <= maxSize) break;
          }
        }
      }
    } catch (e) {
      _logger.severe('Failed to manage cache size, error: $e');
    }
  }

  /// Default iOS options for secure storage
  static IOSOptions _getDefaultIOSOptions() {
    return const IOSOptions(
      accessibility: KeychainAccessibility.unlocked,
      synchronizable: false,
    );
  }

  /// Default Android options for secure storage
  static AndroidOptions _getDefaultAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  /// Ensure initialization
  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
      throw CacheException('CacheHelper was not initialized. Call init() first.');
    }
  }
}
