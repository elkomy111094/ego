import 'dart:convert';
import 'package:http/http.dart' as http;
import 'notification_model.dart';
import 'notification_settings_controller.dart';

class EmailSmsFallback {
  static const String _baseUrl = 'https://your-api.com';
  static const String _apiKey = 'your-api-key';

  static Future<bool> sendEmail(NotificationData data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/send-email'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'to': 'user@example.com',
          'subject': data.title ?? 'Notification',
          'body': _formatEmailBody(data),
          'html': _formatEmailHtml(data),
        }),
      );

      if (response.statusCode == 200) {
        print("📧 Email sent successfully for ${data.title}");
        return true;
      } else {
        print("📧 Email failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("📧 Email error: $e");
      return false;
    }
  }

  static Future<bool> sendSms(NotificationData data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/send-sms'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'to': '+1234567890',
          'message': _formatSmsMessage(data),
        }),
      );

      if (response.statusCode == 200) {
        print("📱 SMS sent successfully for ${data.title}");
        return true;
      } else {
        print("📱 SMS failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("📱 SMS error: $e");
      return false;
    }
  }

  static String _formatEmailBody(NotificationData data) {
    final buffer = StringBuffer();
    buffer.writeln('You have a new notification:');
    buffer.writeln();
    if (data.title != null) buffer.writeln('Title: ${data.title}');
    if (data.body != null) buffer.writeln('Message: ${data.body}');
    buffer.writeln('Type: ${data.type.name}');
    buffer.writeln('Priority: ${data.priority.name}');
    buffer.writeln('Received: ${data.receivedAt}');

    if (data.actions.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('Available actions:');
      for (final action in data.actions) {
        buffer.writeln('- ${action.title}');
      }
    }

    return buffer.toString();
  }

  static String _formatEmailHtml(NotificationData data) {
    final buffer = StringBuffer();
    buffer.writeln('<html><body>');
    buffer.writeln('<h2>New Notification</h2>');

    if (data.imageUrl != null) {
      buffer.writeln('<img src="${data.imageUrl}" alt="Notification Image" style="max-width: 300px;">');
    }

    buffer.writeln('<table border="1" style="border-collapse: collapse;">');
    if (data.title != null) buffer.writeln('<tr><td><strong>Title</strong></td><td>${data.title}</td></tr>');
    if (data.body != null) buffer.writeln('<tr><td><strong>Message</strong></td><td>${data.body}</td></tr>');
    buffer.writeln('<tr><td><strong>Type</strong></td><td>${data.type.name}</td></tr>');
    buffer.writeln('<tr><td><strong>Priority</strong></td><td>${data.priority.name}</td></tr>');
    buffer.writeln('<tr><td><strong>Received</strong></td><td>${data.receivedAt}</td></tr>');
    buffer.writeln('</table>');

    if (data.actions.isNotEmpty) {
      buffer.writeln('<h3>Actions</h3>');
      buffer.writeln('<ul>');
      for (final action in data.actions) {
        buffer.writeln('<li>${action.title}</li>');
      }
      buffer.writeln('</ul>');
    }

    buffer.writeln('</body></html>');
    return buffer.toString();
  }

  static String _formatSmsMessage(NotificationData data) {
    final buffer = StringBuffer();
    if (data.title != null) {
      buffer.write('${data.title}: ');
    }
    if (data.body != null) {
      buffer.write(data.body);
    }

    final message = buffer.toString();
    return message.length > 160 ? '${message.substring(0, 157)}...' : message;
  }
}// email_sms_fallback.dart placeholder
