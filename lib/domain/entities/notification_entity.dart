class NotificationEntity {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.duration,
  });

  factory NotificationEntity.fromNow({
    required int id,
    required String title,
    required String body,
    required Duration duration,
  }) => NotificationEntity(
    id: id,
    title: title,
    body: body,
    createdAt: DateTime.now(),
    duration: duration,
  );

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
      duration: Duration(milliseconds: json['duration'] as int? ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'duration': duration.inMilliseconds,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final Duration duration;

  @override
  String toString() {
    return '''
    NotificationEntity(id: $id, title: $title, body: $body,
    createdAt: $createdAt, duration: $duration)
    ''';
  }
}
