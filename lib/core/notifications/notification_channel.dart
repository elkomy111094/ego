import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_model.dart';

class NotificationChannels {
  static const String defaultChannel = 'default';
  static const String highPriorityChannel = 'high_priority';
  static const String lowPriorityChannel = 'low_priority';
  static const String promotionalChannel = 'promotional';
  static const String systemChannel = 'system';

  static List<AndroidNotificationChannel> get channels => [
    const AndroidNotificationChannel(
      defaultChannel,
      'Default Notifications',
      description: 'General notifications',
      importance: Importance.defaultImportance,
      playSound: true,
      enableVibration: true,
    ),
    const AndroidNotificationChannel(
      highPriorityChannel,
      'High Priority',
      description: 'Important notifications that require immediate attention',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    ),
    const AndroidNotificationChannel(
      lowPriorityChannel,
      'Low Priority',
      description: 'Less important notifications',
      importance: Importance.low,
      playSound: false,
      enableVibration: false,
    ),
    const AndroidNotificationChannel(
      promotionalChannel,
      'Promotional',
      description: 'Marketing and promotional notifications',
      importance: Importance.defaultImportance,
      playSound: false,
      enableVibration: false,
    ),
    const AndroidNotificationChannel(
      systemChannel,
      'System',
      description: 'System notifications',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    ),
  ];

  static String getChannelForPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.urgent:
      case NotificationPriority.high:
        return highPriorityChannel;
      case NotificationPriority.low:
        return lowPriorityChannel;
      case NotificationPriority.normal:
        return defaultChannel;
    }
  }

  static String getChannelForType(NotificationType type) {
    switch (type) {
      case NotificationType.promotional:
        return promotionalChannel;
      case NotificationType.system:
        return systemChannel;
      default:
        return defaultChannel;
    }
  }
}