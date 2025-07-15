import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../inbox_controller.dart';
import '../notification_model.dart';
import '../notification_analytics.dart';

class NotificationInbox extends StatefulWidget {
  const NotificationInbox({super.key});

  @override
  State<NotificationInbox> createState() => _NotificationInboxState();
}

class _NotificationInboxState extends State<NotificationInbox> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NotificationType? _selectedType;
  NotificationPriority? _selectedPriority;
  bool _showOnlyUnread = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    InboxController.instance.addListener(_onInboxChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    InboxController.instance.removeListener(_onInboxChanged);
    super.dispose();
  }

  void _onInboxChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.inbox),
                  const SizedBox(width: 4),
                  Text('All (${InboxController.instance.all.length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.circle),
                  const SizedBox(width: 4),
                  Text('Unread (${InboxController.instance.unreadCount})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.analytics),
                  const SizedBox(width: 4),
                  const Text('Analytics'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'filter', child: Text('Filter')),
              const PopupMenuItem(value: 'mark_all_read', child: Text('Mark All Read')),
              const PopupMenuItem(value: 'clear_all', child: Text('Clear All')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationList(InboxController.instance.all),
          _buildNotificationList(InboxController.instance.unread),
          _buildAnalyticsView(),
        ],
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationData> notifications) {
    List<NotificationData> filtered = notifications;

    if (_selectedType != null) {
      filtered = filtered.where((n) => n.type == _selectedType).toList();
    }
    if (_selectedPriority != null) {
      filtered = filtered.where((n) => n.priority == _selectedPriority).toList();
    }
    if (_showOnlyUnread) {
      filtered = filtered.where((n) => !n.isRead).toList();
    }

    if (filtered.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No notifications', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final notification = filtered[index];
        return _buildNotificationTile(notification);
      },
    );
  }

  Widget _buildNotificationTile(NotificationData notification) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        InboxController.instance.delete(notification.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification deleted')),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          leading: _buildNotificationIcon(notification),
          title: Text(
            notification.title ?? 'No title',
            style: TextStyle(
              fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notification.body != null)
                Text(
                  notification.body!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _buildTypeChip(notification.type),
                  const SizedBox(width: 4),
                  _buildPriorityChip(notification.priority),
                  const Spacer(),
                  Text(
                    _formatTime(notification.receivedAt),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          trailing: notification.isRead
              ? null
              : const Icon(Icons.circle, color: Colors.blue, size: 8),
          onTap: () => _handleNotificationTap(notification),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationData notification) {
    if (notification.iconUrl != null) {
      return CachedNetworkImage(
        imageUrl: notification.iconUrl!,
        width: 40,
        height: 40,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => _getDefaultIcon(notification.type),
      );
    }
    return _getDefaultIcon(notification.type);
  }

  Widget _getDefaultIcon(NotificationType type) {
    IconData icon;
    Color color;

    switch (type) {
      case NotificationType.error:
        icon = Icons.error;
        color = Colors.red;
        break;
      case NotificationType.warning:
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case NotificationType.success:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case NotificationType.promotional:
        icon = Icons.local_offer;
        color = Colors.purple;
        break;
      case NotificationType.system:
        icon = Icons.settings;
        color = Colors.grey;
        break;
      default:
        icon = Icons.notifications;
        color = Colors.blue;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildTypeChip(NotificationType type) {
    return Chip(
      label: Text(type.name, style: const TextStyle(fontSize: 10)),
      backgroundColor: _getTypeColor(type).withOpacity(0.1),
      side: BorderSide(color: _getTypeColor(type)),
    );
  }

  Widget _buildPriorityChip(NotificationPriority priority) {
    return Chip(
      label: Text(priority.name, style: const TextStyle(fontSize: 10)),
      backgroundColor: _getPriorityColor(priority).withOpacity(0.1),
      side: BorderSide(color: _getPriorityColor(priority)),
    );
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.error:
        return Colors.red;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.success:
        return Colors.green;
      case NotificationType.promotional:
        return Colors.purple;
      case NotificationType.system:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  Color _getPriorityColor(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Colors.green;
      case NotificationPriority.normal:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }

  Widget _buildAnalyticsView() {
    final stats = NotificationAnalytics.getStats();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatCard('Total Notifications', stats['total_notifications']?.toString() ?? '0'),
        const SizedBox(height: 16),
        _buildStatCard('Unread Count', InboxController.instance.unreadCount.toString()),
        const SizedBox(height: 16),
        _buildEventsChart(stats['events']),
        const SizedBox(height: 16),
        _buildTypesChart(stats['types']),
        const SizedBox(height: 16),
        _buildPrioritiesChart(stats['priorities']),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16)),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsChart(Map<String, dynamic>? events) {
    if (events == null || events.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No events data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...events.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value.toString()),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTypesChart(Map<String, dynamic>? types) {
    if (types == null || types.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No types data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Types', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...types.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getTypeColor(NotificationType.values.firstWhere(
                                (e) => e.name == entry.key,
                            orElse: () => NotificationType.info,
                          )),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.key),
                    ],
                  ),
                  Text(entry.value.toString()),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPrioritiesChart(Map<String, dynamic>? priorities) {
    if (priorities == null || priorities.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No priorities data available'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Priorities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...priorities.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _getPriorityColor(NotificationPriority.values.firstWhere(
                                (e) => e.name == entry.key,
                            orElse: () => NotificationPriority.normal,
                          )),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.key),
                    ],
                  ),
                  Text(entry.value.toString()),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  void _handleNotificationTap(NotificationData notification) async {
    await InboxController.instance.markAsRead(notification.id);
    await NotificationAnalytics.trackEvent('notification_opened_from_inbox', notification);

    if (notification.route != null) {
      Navigator.of(context).pushNamed(notification.route!, arguments: notification.payload);
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'filter':
        _showFilterDialog();
        break;
      case 'mark_all_read':
        InboxController.instance.markAllAsRead();
        break;
      case 'clear_all':
        _showClearAllDialog();
        break;
      case 'settings':
        Navigator.of(context).pushNamed('/notification_settings');
        break;
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Notifications'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<NotificationType?>(
              value: _selectedType,
              hint: const Text('Select Type'),
              isExpanded: true,
              items: [
                const DropdownMenuItem(value: null, child: Text('All Types')),
                ...NotificationType.values.map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.name),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
                Navigator.of(context).pop();
              },
            ),
            DropdownButton<NotificationPriority?>(
              value: _selectedPriority,
              hint: const Text('Select Priority'),
              isExpanded: true,
              items: [
                const DropdownMenuItem(value: null, child: Text('All Priorities')),
                ...NotificationPriority.values.map((priority) => DropdownMenuItem(
                  value: priority,
                  child: Text(priority.name),
                )),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
                Navigator.of(context).pop();
              },
            ),
            CheckboxListTile(
              title: const Text('Show only unread'),
              value: _showOnlyUnread,
              onChanged: (value) {
                setState(() {
                  _showOnlyUnread = value ?? false;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to delete all notifications? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              InboxController.instance.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}// widgets/notification_inbox.dart placeholder
