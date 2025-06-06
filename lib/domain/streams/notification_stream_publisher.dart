import 'package:mulmuger/domain/streams/stream_publisher.dart';

abstract interface class NotificationStreamPublisher
    implements StreamPublisher<double> {
  void addWater({double value});
}
