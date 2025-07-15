import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsController {
  static SharedPreferences? _prefs;

  static const _emailFallbackKey = 'email_fallback';
  static const _smsFallbackKey = 'sms_fallback';
  static const _showForegroundKey = 'show_foreground';
  static const _alwaysUseFallbackKey = 'always_use_fallback';
  static const _oneSignalEnabledKey = 'onesignal_enabled';
  static const _oneSignalAppIdKey = 'onesignal_app_id';
  static const _enableAnalyticsKey = 'enable_analytics';
  static const _quietHoursStartKey = 'quiet_hours_start';
  static const _quietHoursEndKey = 'quiet_hours_end';
  static const _enableQuietHoursKey = 'enable_quiet_hours';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static bool get emailFallbackEnabled => _prefs?.getBool(_emailFallbackKey) ?? false;
  static set emailFallbackEnabled(bool value) => _prefs?.setBool(_emailFallbackKey, value);

  static bool get smsFallbackEnabled => _prefs?.getBool(_smsFallbackKey) ?? false;
  static set smsFallbackEnabled(bool value) => _prefs?.setBool(_smsFallbackKey, value);

  static bool get showForegroundNotifications => _prefs?.getBool(_showForegroundKey) ?? true;
  static set showForegroundNotifications(bool value) => _prefs?.setBool(_showForegroundKey, value);

  static bool get alwaysUseFallback => _prefs?.getBool(_alwaysUseFallbackKey) ?? false;
  static set alwaysUseFallback(bool value) => _prefs?.setBool(_alwaysUseFallbackKey, value);

  static bool get oneSignalEnabled => _prefs?.getBool(_oneSignalEnabledKey) ?? false;
  static set oneSignalEnabled(bool value) => _prefs?.setBool(_oneSignalEnabledKey, value);

  static String get oneSignalAppId => _prefs?.getString(_oneSignalAppIdKey) ?? '';
  static set oneSignalAppId(String value) => _prefs?.setString(_oneSignalAppIdKey, value);

  static bool get enableAnalytics => _prefs?.getBool(_enableAnalyticsKey) ?? true;
  static set enableAnalytics(bool value) => _prefs?.setBool(_enableAnalyticsKey, value);

  static int get quietHoursStart => _prefs?.getInt(_quietHoursStartKey) ?? 22;
  static set quietHoursStart(int value) => _prefs?.setInt(_quietHoursStartKey, value);

  static int get quietHoursEnd => _prefs?.getInt(_quietHoursEndKey) ?? 8;
  static set quietHoursEnd(int value) => _prefs?.setInt(_quietHoursEndKey, value);


}// notification_settings_controller.dart placeholder
