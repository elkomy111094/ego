import 'package:flutter/material.dart';
import '../core/notifications/notification_settings_controller.dart';


class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure settings are initialized
    NotificationSettingsController.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Notification Display'),
          _buildSwitchTile(
            title: 'Show Foreground Notifications',
            value: NotificationSettingsController.showForegroundNotifications,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.showForegroundNotifications = value;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Fallback Options'),
          _buildSwitchTile(
            title: 'Enable Email Fallback',
            subtitle: 'Receive notifications via email when offline',
            value: NotificationSettingsController.emailFallbackEnabled,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.emailFallbackEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Enable SMS Fallback',
            subtitle: 'Receive notifications via SMS when offline',
            value: NotificationSettingsController.smsFallbackEnabled,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.smsFallbackEnabled = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Always Use Fallback',
            subtitle: 'Send email/SMS regardless of connectivity',
            value: NotificationSettingsController.alwaysUseFallback,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.alwaysUseFallback = value;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('OneSignal Integration'),
          _buildSwitchTile(
            title: 'Enable OneSignal',
            subtitle: 'Use OneSignal for push notifications',
            value: NotificationSettingsController.oneSignalEnabled,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.oneSignalEnabled = value;
              });
            },
          ),
          _buildTextFieldTile(
            title: 'OneSignal App ID',
            value: NotificationSettingsController.oneSignalAppId,
            onChanged: (value) {
              NotificationSettingsController.oneSignalAppId = value;
            },
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Analytics'),
          _buildSwitchTile(
            title: 'Enable Analytics',
            subtitle: 'Track notification events and statistics',
            value: NotificationSettingsController.enableAnalytics,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.enableAnalytics = value;
              });
            },
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Quiet Hours'),
          _buildHourPickerTile(
            title: 'Quiet Hours Start',
            hour: NotificationSettingsController.quietHoursStart,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.quietHoursStart = value;
              });
            },
          ),
          _buildHourPickerTile(
            title: 'Quiet Hours End',
            hour: NotificationSettingsController.quietHoursEnd,
            onChanged: (value) {
              setState(() {
                NotificationSettingsController.quietHoursEnd = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildTextFieldTile({
    required String title,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: TextField(
        controller: TextEditingController(text: value),
        onChanged: onChanged,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter App ID',
        ),
      ),
    );
  }

  Widget _buildHourPickerTile({
    required String title,
    required int hour,
    required ValueChanged<int> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text('$hour:00'),
      onTap: () async {
        final selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: hour, minute: 0),
        );
        if (selectedTime != null) {
          onChanged(selectedTime.hour);
        }
      },
    );
  }
}