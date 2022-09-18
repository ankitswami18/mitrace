import 'dart:async';

class LocationBloc {
  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<String> _streamController = StreamController<String>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<String> get streamBlocModel => _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM

  void updateWith({required String location}) {
    _streamController.sink.add(location);
  }
}
