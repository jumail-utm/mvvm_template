import 'package:flutter/foundation.dart';

class Viewmodel with ChangeNotifier {
  bool _busy = false;

  get busy => _busy;

  void turnBusy() {
    _busy = true;
    notifyListeners();
  }

  void turnIdle() {
    _busy = false;
    notifyListeners();
  }

  // A convenient method, to implicitly write the turnBusy()... turnIdle()
  void update(AsyncCallback fn) async {
    turnBusy();
    if (fn != null) await fn();
    turnIdle();
  }
}
