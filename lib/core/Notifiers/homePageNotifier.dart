import 'package:flutter/foundation.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'package:notes_app/core/services/Fstore.dart';
import 'package:notes_app/locator.dart';

class HomePageNotifier extends ChangeNotifier {
  Fstore db = locator.get<Fstore>();
  List notes = [];
  bool busy = false;
  String imageURL = " ";

  HomePageNotifier() {
    print(notes.length);
    allNotes();
    getImageURL();
  }

  void allNotes() async {
    db.notesStream.listen((event) {
      isBusy(true);
      notes = [];

      event.docs.forEach((doc) {
        print(doc.data());
        notes.add(NotesModel.fromMap(doc.data(), doc.id));
        print("helloo");
      });

      isBusy(false);
      notifyListeners();
    });
  }

  void getImageURL() async {
    isBusy(true);
    imageURL = await db.getImageUrl();
    isBusy(false);
  }

  void isBusy(bool b) {
    busy = b;
    notifyListeners();
  }
}
