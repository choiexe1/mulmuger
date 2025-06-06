import 'dart:async';

abstract interface class StreamPublisher<T> {
  StreamController<T> get controller;
  Stream<T> get stream;
}
