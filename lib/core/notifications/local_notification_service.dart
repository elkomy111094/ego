// local_notification_service.dart placeholder
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'notification_model.dart';
import 'notification_channel.dart';

class LocalNotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static final onClick = BehaviorSubject<NotificationData>();
  static final onAction = BehaviorSubject<NotificationActionResponse>();
  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final data = NotificationData.fromPayload(response.payload);
        if (response.actionId != null) {
          onAction.add(NotificationActionResponse(
            notification: data,
            actionId: response.actionId!,
          ));
        } else {
          onClick.add(data);
        }
      },
    );

    if (Platform.isAndroid) {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidPlugin != null) {
        for (final channel in NotificationChannels.channels) {
          await androidPlugin.createNotificationChannel(channel);
        }
      }
    }

    _initialized = true;
  }

  static Future<void> show(NotificationData data) async {
    try {
      final channelId = NotificationChannels.getChannelForType(data.type);
      final channel = NotificationChannels.channels.firstWhere((c) => c.id == channelId);

      String? largeIconPath;
      String? bigPicturePath;

      if (data.iconUrl != null) {
        largeIconPath = await _downloadAndSaveFile(data.iconUrl!, 'icon_${data.id}');
      }

      if (data.imageUrl != null) {
        bigPicturePath = await _downloadAndSaveFile(data.imageUrl!, 'image_${data.id}');
      }

      final androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: _getPriorityForNotification(data.priority),
        largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
        styleInformation: bigPicturePath != null
            ? BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          largeIcon: largeIconPath != null ? FilePathAndroidBitmap(largeIconPath) : null,
          contentTitle: data.title,
          summaryText: data.body,
        )
            : data.body != null && data.body!.length > 50
            ? BigTextStyleInformation(
          data.body!,
          contentTitle: data.title,
        )
            : null,
        actions: data.actions.map((action) => AndroidNotificationAction(
          action.id,
          action.title,
          cancelNotification: false,
        )).toList(),
      );

      final iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: channel.playSound,
        attachments: data.imageUrl != null
            ? [DarwinNotificationAttachment(data.imageUrl!)]
            : null,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.show(
        data.id.hashCode,
        data.title,
        data.body,
        details,
        payload: _createPayload(data),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  static Future<void> schedule(NotificationData data, DateTime time) async {
    try {
      final channelId = NotificationChannels.getChannelForType(data.type);
      final channel = NotificationChannels.channels.firstWhere((c) => c.id == channelId);

      final androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: channel.importance,
        priority: _getPriorityForNotification(data.priority),
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: const DarwinNotificationDetails(),
      );

      await _plugin.zonedSchedule(
        data.id.hashCode,
        data.title,
        data.body,
        tz.TZDateTime.from(time, tz.local),
        details,
        payload: _createPayload(data),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }

  static Future<void> cancel(String id) async {
    await _plugin.cancel(id.hashCode);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  static Future<List<PendingNotificationRequest>> getPending() async {
    return await _plugin.pendingNotificationRequests();
  }

  static Priority _getPriorityForNotification(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.normal:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.urgent:
        return Priority.max;
    }
  }

  static String _createPayload(NotificationData data) {
    final params = <String, String>{
      'id': data.id,
      'type': data.type.name,
      'priority': data.priority.name,
      if (data.title != null) 'title': data.title!,
      if (data.body != null) 'body': data.body!,
      if (data.route != null) 'route': data.route!,
      ...?data.payload?.map((k, v) => MapEntry(k, v.toString())),
    };
    return Uri(queryParameters: params).query;
  }

  static Future<String?> _downloadAndSaveFile(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file.path;
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
    return null;
  }
}

class NotificationActionResponse {
  final NotificationData notification;
  final String actionId;

  NotificationActionResponse({
    required this.notification,
    required this.actionId,
  });
}