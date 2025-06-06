sealed class NotificationAction {
  factory NotificationAction.cancel() = Cancel;
  factory NotificationAction.addWater(double value) = AddWater;
}

class Cancel implements NotificationAction {}

class AddWater implements NotificationAction {
  const AddWater(this.value);

  final double value;
}
