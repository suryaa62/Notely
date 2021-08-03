import 'package:flutter/foundation.dart';
import 'package:notes_app/widgets/profilePageWidgets.dart';

class UpdateFieldNotifier extends ChangeNotifier {
  UpdateFieldNotifier(Future<void> Function(Map<String, dynamic>) func) {
    this.func = func;
    busy = false;
    isChanged = false;
  }

  Future<void> Function(Map<String, dynamic>) func;
  bool busy;
  bool isChanged;

  void isBusy(bool b) {
    busy = b;
    notifyListeners();
  }

  void onChanged(Map<String, dynamic> map) async {
    if (isChanged) {
      isBusy(true);
      await func(map);
      isChanged = false;
      isBusy(false);
    }
  }
}
