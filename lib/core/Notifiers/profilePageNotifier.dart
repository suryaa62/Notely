import 'package:flutter/foundation.dart';
import 'package:notes_app/core/Notifiers/widgets/profilePageWidgetsNotifiers.dart';
import 'package:notes_app/core/models/userModel.dart';
import 'package:notes_app/locator.dart';
import 'package:notes_app/core/services/Fstore.dart';

enum statesProfilePage {
  busy,
  free,
}

class ProfilePageNotifier extends ChangeNotifier {
  Fstore db = locator.get<Fstore>();
  statesProfilePage _status = statesProfilePage.busy;
  statesProfilePage get status => _status;
  UserModel user;
  bool busy;
  UpdateFieldNotifier nameFieldNotifier;
  UpdateFieldNotifier emailFieldNotifier;
  UpdateFieldNotifier phoneFieldNotifier;

  ProfilePageNotifier() {
    print("-------------CALLED----------");
    busy = false;
    user = UserModel(email: " ", name: " ", phoneNo: " ", imageURL: " ");
    read();

    nameFieldNotifier = UpdateFieldNotifier(update);
    emailFieldNotifier = UpdateFieldNotifier(update);
    phoneFieldNotifier = UpdateFieldNotifier(update);
  }

  void read() async {
    try {
      isBusy(true);
      user = await db.readUser();
      isBusy(false);
      print("-----------------${user.name}");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(Map<String, dynamic> map) async {
    try {
      //isBusy(true);
      await db.updateUser(map);
      print("UPDATED");
      if (map.containsKey("name"))
        user.name = map['name'];
      else if (map.containsKey("email"))
        user.email = map['email'];
      else if (map.containsKey("imageURL")) user.imageURL = map["imageURL"];
      // isBusy(false);
    } catch (e) {
      print(e.toString());
    }
  }

  void isBusy(bool b) {
    busy = b;
    print(b);
    notifyListeners();
  }
}
