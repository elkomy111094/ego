import 'dart:io';
import 'package:logger/logger.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ego/core/cache/cache_helper.dart';
import 'package:ego/core/cache/cache_keys.dart';

enum AppUpdateStatus { forceUpdate, optionalUpdate, upToDate }

class VersionHelper {
  static final Logger logger = Logger();

  /// ✅ Normalize a version like "1.0" to "1.0.0"
  static Version normalize(String version) {
    logger.i("Normalizing version: $version");
    try {
      final parts = version.split('.');
      while (parts.length < 3) {
        parts.add('0');
      }
      final normalized = Version.parse(parts.join('.'));
      logger.i("Normalized version: $normalized");
      return normalized;
    } catch (e) {
      logger.e("Failed to normalize version: $version | Error: $e");
      return Version(0, 0, 0); // fallback version
    }
  }

  /// ✅ Compare if latest > current
  static bool isGreater(String latest, String current) {
    final latestVersion = normalize(latest);
    final currentVersion = normalize(current);
    final result = latestVersion > currentVersion;
    logger.i("Is $latest > $current ? $result");
    return result;
  }

  /// ✅ Compare if current < forcedUpgrade
  static bool isLower(String current, String forcedUpgrade) {
    final currentVersion = normalize(current);
    final forcedVersion = normalize(forcedUpgrade);
    final result = currentVersion < forcedVersion;
    logger.i("Is $current < $forcedUpgrade ? $result");
    return result;
  }

  /// ✅ Get current app version safely
  static Future<String> getCurrentAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      if (version.isEmpty || version == 'unknown') {
        throw FormatException('Invalid version from platform: $version');
      }
      return version;
    } catch (e) {
      logger.e('ERROR fetching app version: $e');
      return '4.0.0'; // fallback version
    }
  }

  /// ✅ Get cached version if exists, else fetch and cache it
  static Future<String> getCachedOrCurrentAppVersion() async {
    final String? cached = await CacheHelper.getData(PrefKeys.currentAppVersion);
    if (cached != null && cached.isNotEmpty) {
      logger.i("Using cached app version: $cached");
      return cached;
    }

    final version = await getCurrentAppVersion();
    await CacheHelper.saveData( key: PrefKeys.currentAppVersion, value: version);
    return version;
  }

  /// ✅ Check update status based on platform (Android/iOS)
  static AppUpdateStatus checkAppUpdateStatus({
    required String currentVersion,
    required String androidBuild,
    required String iosBuild,
    required String forceUpgradeVersion,
  }) {
    logger.i("Checking app update status...");
    logger.i("Platform: ${Platform.isAndroid ? "Android" : "iOS"}");
    logger.i("Current version: $currentVersion");
    logger.i("Force upgrade version: $forceUpgradeVersion");

    if (isLower(currentVersion, forceUpgradeVersion)) {
      logger.w("FORCE UPDATE required");
      return AppUpdateStatus.forceUpdate;
    }

    final latestBuild = Platform.isAndroid ? androidBuild : iosBuild;

    if (isGreater(latestBuild, currentVersion)) {
      logger.w("OPTIONAL UPDATE available");
      return AppUpdateStatus.optionalUpdate;
    }

    logger.i("App is UP TO DATE");
    return AppUpdateStatus.upToDate;
  }
}
