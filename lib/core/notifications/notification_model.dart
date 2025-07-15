enum NotificationType {
  info,
  warning,
  error,
  success,
  promotional,
  system,
}

enum NotificationPriority {
  low,
  normal,
  high,
  urgent,
}

class NotificationData {
  final String id;
  final String? title;
  final String? body;
  final String? route;
  final Map<String, dynamic>? payload;
  final DateTime receivedAt;
  final NotificationType type;
  final NotificationPriority priority;
  final String? imageUrl;
  final String? iconUrl;
  final bool isRead;
  final DateTime? expiresAt;
  final List<NotificationAction> actions;

  NotificationData({
    required this.id,
    this.title,
    this.body,
    this.route,
    this.payload,
    required this.receivedAt,
    this.type = NotificationType.info,
    this.priority = NotificationPriority.normal,
    this.imageUrl,
    this.iconUrl,
    this.isRead = false,
    this.expiresAt,
    this.actions = const [],
  });

  NotificationData copyWith({
    String? id,
    String? title,
    String? body,
    String? route,
    Map<String, dynamic>? payload,
    DateTime? receivedAt,
    NotificationType? type,
    NotificationPriority? priority,
    String? imageUrl,
    String? iconUrl,
    bool? isRead,
    DateTime? expiresAt,
    List<NotificationAction>? actions,
  }) {
    return NotificationData(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      route: route ?? this.route,
      payload: payload ?? this.payload,
      receivedAt: receivedAt ?? this.receivedAt,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      imageUrl: imageUrl ?? this.imageUrl,
      iconUrl: iconUrl ?? this.iconUrl,
      isRead: isRead ?? this.isRead,
      expiresAt: expiresAt ?? this.expiresAt,
      actions: actions ?? this.actions,
    );
  }

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: map['title'],
      body: map['body'],
      route: map['route'],
      payload: Map<String, dynamic>.from(map['payload'] ?? map),
      receivedAt: map['receivedAt'] != null ? DateTime.parse(map['receivedAt']) : DateTime.now(),
      type: NotificationType.values.firstWhere(
            (e) => e.name == map['type'],
        orElse: () => NotificationType.info,
      ),
      priority: NotificationPriority.values.firstWhere(
            (e) => e.name == map['priority'],
        orElse: () => NotificationPriority.normal,
      ),
      imageUrl: map['imageUrl'],
      iconUrl: map['iconUrl'],
      isRead: map['isRead'] ?? false,
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : null,
      actions: (map['actions'] as List?)?.map((e) => NotificationAction.fromMap(e)).toList() ?? [],
    );
  }

  factory NotificationData.fromPayload(String? payload) {
    if (payload == null) {
      return NotificationData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        receivedAt: DateTime.now(),
      );
    }

    try {
      final uri = Uri.parse('?$payload');
      final params = uri.queryParameters;
      return NotificationData(
        id: params['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: params['title'],
        body: params['body'],
        route: params['route'],
        type: NotificationType.values.firstWhere(
              (e) => e.name == params['type'],
          orElse: () => NotificationType.info,
        ),
        priority: NotificationPriority.values.firstWhere(
              (e) => e.name == params['priority'],
          orElse: () => NotificationPriority.normal,
        ),
        payload: Map<String, dynamic>.from(params)
          ..removeWhere((key, value) => ['id', 'title', 'body', 'route', 'type', 'priority'].contains(key)),
        receivedAt: DateTime.now(),
      );
    } catch (e) {
      return NotificationData(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        receivedAt: DateTime.now(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'route': route,
    'payload': payload,
    'receivedAt': receivedAt.toIso8601String(),
    'type': type.name,
    'priority': priority.name,
    'imageUrl': imageUrl,
    'iconUrl': iconUrl,
    'isRead': isRead,
    'expiresAt': expiresAt?.toIso8601String(),
    'actions': actions.map((e) => e.toJson()).toList(),
  };

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      route: json['route'],
      payload: json['payload'] != null ? Map<String, dynamic>.from(json['payload']) : null,
      receivedAt: DateTime.parse(json['receivedAt']),
      type: NotificationType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => NotificationType.info,
      ),
      priority: NotificationPriority.values.firstWhere(
            (e) => e.name == json['priority'],
        orElse: () => NotificationPriority.normal,
      ),
      imageUrl: json['imageUrl'],
      iconUrl: json['iconUrl'],
      isRead: json['isRead'] ?? false,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      actions: (json['actions'] as List?)?.map((e) => NotificationAction.fromJson(e)).toList() ?? [],
    );
  }
}

class NotificationAction {
  final String id;
  final String title;
  final String? route;
  final Map<String, dynamic>? payload;
  final bool isDestructive;

  NotificationAction({
    required this.id,
    required this.title,
    this.route,
    this.payload,
    this.isDestructive = false,
  });

  factory NotificationAction.fromMap(Map<String, dynamic> map) {
    return NotificationAction(
      id: map['id'],
      title: map['title'],
      route: map['route'],
      payload: map['payload'],
      isDestructive: map['isDestructive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'route': route,
    'payload': payload,
    'isDestructive': isDestructive,
  };

  factory NotificationAction.fromJson(Map<String, dynamic> json) {
    return NotificationAction(
      id: json['id'],
      title: json['title'],
      route: json['route'],
      payload: json['payload'],
      isDestructive: json['isDestructive'] ?? false,
    );
  }
}// notification_model.dart placeholder
