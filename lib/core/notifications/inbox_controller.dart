import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';
import 'notification_model.dart';

class InboxController extends ChangeNotifier {
  static const _boxName = 'notification_inbox';
  static InboxController? _instance;
  Box? _box;

  static InboxController get instance => _instance ??= InboxController._();
  InboxController._();

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    notifyListeners();
  }

  List<NotificationData> get all {
    if (_box == null) return [];
    return _box!.values
        .map((e) => NotificationData.fromJson(Map<String, dynamic>.from(e)))
        .where((notification) => !notification.isExpired)
        .toList()
      ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));
  }

  List<NotificationData> get unread => all.where((n) => !n.isRead).toList();

  List<NotificationData> getByType(NotificationType type) =>
      all.where((n) => n.type == type).toList();

  List<NotificationData> getByPriority(NotificationPriority priority) =>
      all.where((n) => n.priority == priority).toList();

  int get unreadCount => unread.length;

  Future<void> add(NotificationData data) async {
    if (_box == null) return;
    await _box!.put(data.id, data.toJson());
    notifyListeners();
  }

  Future<void> markAsRead(String id) async {
    if (_box == null) return;
    final notification = all.firstWhere((n) => n.id == id);
    final updated = notification.copyWith(isRead: true);
    await _box!.put(id, updated.toJson());
    notifyListeners();
  }

  Future<void> markAllAsRead() async {
    if (_box == null) return;
    for (final notification in unread) {
      final updated = notification.copyWith(isRead: true);
      await _box!.put(notification.id, updated.toJson());
    }
    notifyListeners();
  }

  Future<void> delete(String id) async {
    if (_box == null) return;
    await _box!.delete(id);
    notifyListeners();
  }

  Future<void> clear() async {
    if (_box == null) return;
    await _box!.clear();
    notifyListeners();
  }

  Future<void> clearExpired() async {
    if (_box == null) return;
    final expired = all.where((n) => n.isExpired).toList();
    for (final notification in expired) {
      await _box!.delete(notification.id);
    }
    if (expired.isNotEmpty) notifyListeners();
  }
}// inbox_controller.dart placeholder
