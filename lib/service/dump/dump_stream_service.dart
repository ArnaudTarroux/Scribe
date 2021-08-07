import 'dart:async';

class DumpStreamService {
  StreamController _dumpStreamController;

  DumpStreamService(StreamController dumpStreamController) {
    this._dumpStreamController = dumpStreamController;
  }

  void send(String data) {
    this._dumpStreamController.sink.add(data);
  }
}