class NotificationEntity {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.duration,
  });

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
