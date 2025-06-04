enum NotificationType {
  immediate(id: 1),
  duration(id: 2),
  schedule(id: 3);

  const NotificationType({required this.id});

  final int id;
}
