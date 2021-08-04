import 'package:flutter/foundation.dart';
import 'package:notes_app/core/models/notesModel.dart';

class DetailsPageNotifier extends ChangeNotifier {
  NotesModel note;

  DetailsPageNotifier.newNote() {
    note = NotesModel();
    note.title = "New Note";
    note.timeLastEdit = DateTime.now();
    note.noteWidgets = [];
  }

  void addTextField() {
    note.noteWidgets.add({'type': 'textfield', "data": " "});
    notifyListeners();
  }

  void addImage() {
    note.noteWidgets
        .add({'type': 'imageURL', "data": "lib/assets/images/profile.jpeg"});
    notifyListeners();
  }

  void addTodo() {
    note.noteWidgets.add({
      'type': 'todo',
      "data": {"unchecked": [], "checked": []}
    });
    notifyListeners();
  }

  void addReminder() {
    note.noteWidgets.insert(0, {'type': 'reminder', "data": DateTime.now()});
    print(note.noteWidgets[0]['data']);
    notifyListeners();
  }

  void display() {
    print(note.noteWidgets);
  }
}
