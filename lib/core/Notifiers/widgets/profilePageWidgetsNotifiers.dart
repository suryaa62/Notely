import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
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

class UpdateImageNotifier extends ChangeNotifier {
  bool busy;
  Future<String> Function(String, String) uploadFunc;
  Future<String> Function(XFile, String) uploadFuncWeb;

  Future<void> Function(Map<String, dynamic>) updateFunc;
  String cloudPath;
  String fieldName;

  UpdateImageNotifier({
    this.updateFunc,
    this.uploadFunc,
    this.cloudPath,
    this.fieldName,
    this.uploadFuncWeb,
  }) {
    busy = false;
  }

  void isBusy(bool b) {
    busy = b;
    notifyListeners();
  }

  Future<String> uploadImage(
    String filePath,
  ) async {
    isBusy(true);
    String imageURL = await uploadFunc(filePath, cloudPath);
    await updateFunc({fieldName: imageURL});
    isBusy(false);
    return imageURL;
  }

  Future<String> uploadImageWeb(
    XFile f,
  ) async {
    isBusy(true);
    String imageURL = await uploadFuncWeb(f, cloudPath);
    await updateFunc({fieldName: imageURL});
    isBusy(false);
    return imageURL;
  }
}
