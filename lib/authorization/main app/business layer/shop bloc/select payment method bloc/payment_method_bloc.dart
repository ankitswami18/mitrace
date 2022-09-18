import 'dart:async';

class PaymentMethodBloc {
  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<int> _streamController = StreamController<int>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<int> get streamBlocModel => _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM

  void updateWith({required int optionNumber}) {
    _streamController.sink.add(optionNumber);
  }
}
