import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'notification_model.dart';
import 'local_notification_service.dart';
import 'inbox_controller.dart';
import 'email_sms_fallback.dart';
import 'notification_settings_controller.dart';
import 'notification_analytics.dart';

class NotificationManager {
  static final _firebase = FirebaseMessaging.instance;
  static final _connectivity = Connectivity();
  static bool _initialized = false;
  static String? _fcmToken;

  static Future<void> init(BuildContext context) async {
    if (_initialized) return;

    await InboxController.instance.init();
    await LocalNotificationService.init();
    await NotificationSettingsController.init();
    await NotificationAnalytics.init();

    await InboxController.instance.clearExpired();

    final settings = await _firebase.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _fcmToken = await _firebase.getToken();
      print('FCM Token: $_fcmToken');
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    final initialMessage = await _firebase.getInitialMessage();
    if (initialMessage != null) {
      _handleTap(context, NotificationData.fromMap(initialMessage.data));
    }

    FirebaseMessaging.onMessage.listen((message) {
      _handleReceive(context, NotificationData.fromMap(message.data));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleTap(context, NotificationData.fromMap(message.data));
    });

    if (NotificationSettingsController.oneSignalEnabled) {
      OneSignal.initialize(NotificationSettingsController.oneSignalAppId);
      OneSignal.Notifications.requestPermission(true);
      OneSignal.User.pushSubscription.optIn();

      OneSignal.Notifications.addForegroundWillDisplayListener((event) {
        event.preventDefault();
        final data = NotificationData.fromMap(event.notification.additionalData ?? {});
        _handleReceive(context, data);
      });

      OneSignal.Notifications.addClickListener((event) {
        final data = NotificationData.fromMap(event.notification.additionalData ?? {});
        _handleTap(context, data);
      });
    }

    LocalNotificationService.onClick.listen((data) {
      _handleTap(context, data);
    });

    LocalNotificationService.onAction.listen((response) {
      _handleAction(context, response);
    });

    _firebase.onTokenRefresh.listen((token) {
      _fcmToken = token;
      print('FCM Token refreshed: $token');
    });

    _initialized = true;
  }

  static Future<void> _handleTap(BuildContext context, NotificationData data) async {
    await InboxController.instance.markAsRead(data.id);
    await NotificationAnalytics.trackEvent('notification_tapped', data);

    if (data.route != null) {
      Navigator.of(context).pushNamed(data.route!, arguments: data.payload);
    }
  }

  static Future<void> _handleReceive(BuildContext context, NotificationData data) async {
    try {
      await InboxController.instance.add(data);

      if (NotificationSettingsController.showForegroundNotifications) {
        await LocalNotificationService.show(data);
      }
/*
      if (NotificationSettingsController.oneSignalEnabled) {
        await OneSignal.Notifications.setBadgeCount(InboxController.instance.unreadCount);
      }*/

      final connectivityResult = await _connectivity.checkConnectivity();
      final isOffline = connectivityResult == ConnectivityResult.none;

      if (isOffline || NotificationSettingsController.alwaysUseFallback) {
        if (NotificationSettingsController.emailFallbackEnabled) {
          await EmailSmsFallback.sendEmail(data);
        }
        if (NotificationSettingsController.smsFallbackEnabled) {
          await EmailSmsFallback.sendSms(data);
        }
      }

      await NotificationAnalytics.trackEvent('notification_received', data);

    } catch (e) {
      print('Error handling notification: $e');
    }
  }

  static Future<void> _handleAction(BuildContext context, NotificationActionResponse response) async {
    final action = response.notification.actions.firstWhere(
          (a) => a.id == response.actionId,
      orElse: () => NotificationAction(id: response.actionId, title: 'Unknown'),
    );

    await NotificationAnalytics.trackEvent('notification_action_tapped', response.notification, {
      'action_id': action.id,
      'action_title': action.title,
    });

    if (action.route != null) {
      Navigator.of(context).pushNamed(action.route!, arguments: action.payload);
    }
  }

  static Future<void> subscribeToTopic(String topic) async {
    await _firebase.subscribeToTopic(topic);
  }

  static Future<void> unsubscribeFromTopic(String topic) async {
    await _firebase.unsubscribeFromTopic(topic);
  }

  static String? get fcmToken => _fcmToken;

  static Future<void> sendLocalNotification(NotificationData data) async {
    await LocalNotificationService.show(data);
    await InboxController.instance.add(data);
  }

  static Future<void> scheduleLocalNotification(NotificationData data, DateTime time) async {
    await LocalNotificationService.schedule(data, time);
    await InboxController.instance.add(data);
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  final data = NotificationData.fromMap(message.data);
  await InboxController.instance.add(data);
  await LocalNotificationService.show(data);
  await NotificationAnalytics.trackEvent('notification_received_background', data);
}// notification_manager.dart placeholder
