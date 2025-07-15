import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_model.dart';
import 'notification_settings_controller.dart';

class NotificationAnalytics {
  static SharedPreferences? _prefs;
  static const _eventsKey = 'notification_events';
  static const _statsKey = 'notification_stats';

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> trackEvent(String event, NotificationData notification, [Map<String, dynamic>? extraData]) async {
    if (!NotificationSettingsController.enableAnalytics) return;

    final eventData = {
      'event': event,
      'timestamp': DateTime.now().toIso8601String(),
      'notification_id': notification.id,
      'notification_type': notification.type.name,
      'notification_priority': notification.priority.name,
      'has_image': notification.imageUrl != null,
      'has_actions': notification.actions.isNotEmpty,
      ...?extraData,
    };

    final events = getEvents();
    events.add(eventData);

    if (events.length > 1000) {
      events.removeRange(0, events.length - 1000);
    }

    await _prefs?.setString(_eventsKey, jsonEncode(events));
    await _updateStats(event, notification);
  }

  static List<Map<String, dynamic>> getEvents() {
    final eventsJson = _prefs?.getString(_eventsKey);
    if (eventsJson == null) return [];

    try {
      final List<dynamic> decoded = jsonDecode(eventsJson);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  static Future<void> _updateStats(String event, NotificationData notification) async {
    final stats = getStats();

    stats['total_notifications'] = (stats['total_notifications'] ?? 0) + 1;
    stats['events'] = (stats['events'] as Map<String, dynamic>?) ?? {};
    stats['events'][event] = ((stats['events'][event] ?? 0) + 1);

    stats['types'] = (stats['types'] as Map<String, dynamic>?) ?? {};
    stats['types'][notification.type.name] = ((stats['types'][notification.type.name] ?? 0) + 1);

    stats['priorities'] = (stats['priorities'] as Map<String, dynamic>?) ?? {};
    stats['priorities'][notification.priority.name] = ((stats['priorities'][notification.priority.name] ?? 0) + 1);

    final today = DateTime.now().toIso8601String().split('T')[0];
    stats['daily'] = (stats['daily'] as Map<String, dynamic>?) ?? {};
    stats['daily'][today] = ((stats['daily'][today] ?? 0) + 1);

    await _prefs?.setString(_statsKey, jsonEncode(stats));
  }

  static Map<String, dynamic> getStats() {
    final statsJson = _prefs?.getString(_statsKey);
    if (statsJson == null) return {};

    try {
      return jsonDecode(statsJson);
    } catch (e) {
      return {};
    }
  }

  static Future<void> clearAnalytics() async {
    await _prefs?.remove(_eventsKey);
    await _prefs?.remove(_statsKey);
  }
}// notification_analytics.dart placeholder
