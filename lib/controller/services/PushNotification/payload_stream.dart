import 'dart:async';

class PayloadStream {
  static final PayloadStream instance = PayloadStream();

  final payload = StreamController<String>.broadcast();

  Stream<String> get getPayload => payload.stream;
}
