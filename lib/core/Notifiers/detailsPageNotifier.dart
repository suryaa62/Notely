import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'package:notes_app/core/services/Fstore.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';

class DetailsPageNotifier extends ChangeNotifier {
  NotesModel note;
  Fstore db = locator.get<Fstore>();

  DetailsPageNotifier.newNote() {
    note = NotesModel(
        title: "New Note",
        timeLastEdit: DateTime.now(),
        keywords: [],
        noteWidgets: []);
    print("obje                           cCALLED                   t");
  }

  DetailsPageNotifier.showNote(this.note);
  //text operations
  void addTextField() {
    note.noteWidgets.add({'type': 'textfield', "data": ""});
    note.keywords.add('text');
    // notifyListeners();
  }

  bool checkTextField(int index) {
    if (note.noteWidgets[index]['type'] == 'textfield')
      return true;
    else
      return false;
  }

  void updateTitle(String s) {
    note.title = s;
  }

  void updateTextFieldData(String s, int index) {
    note.noteWidgets[index]['data'] = s;
  }

  void addImage(String filepath) async {
    String url;
    url = await db.uploadImage(
        filepath, "/${note.docId}/${DateTime.now().toString()}.jpg");
    note.noteWidgets.add({'type': 'imageURL', "data": url});
    note.keywords.add('Image');
    notifyListeners();
  }

  void addImageWeb(XFile f) async {
    String url;
    url = await db.uploadImageWeb(
        f, "/${note.docId}/${DateTime.now().toString()}.jpg");
    note.noteWidgets.add({'type': 'imageURL', "data": url});
    note.keywords.add('Image');
    notifyListeners();
  }

  //todo operations
  void addTodo() {
    note.noteWidgets.add({
      'type': 'todo',
      "data": {"unchecked": [], "checked": []}
    });

    note.keywords.add('Todo');
    notifyListeners();
  }

  void addnewTodo(int index, String text) {
    note.noteWidgets[index]['data']['unchecked'].add(text);
    notifyListeners();
  }

  void checkedTodo(int index, int itemIndex) {
    String text = note.noteWidgets[index]['data']['unchecked'][itemIndex];
    note.noteWidgets[index]['data']['unchecked'].removeAt(itemIndex);
    note.noteWidgets[index]['data']['checked'].add(text);
    notifyListeners();
  }

  void unCheckedTodo(int index, int itemIndex) {
    String text = note.noteWidgets[index]['data']['checked'][itemIndex];
    note.noteWidgets[index]['data']['checked'].removeAt(itemIndex);
    note.noteWidgets[index]['data']['unchecked'].add(text);
    notifyListeners();
  }

  void deleteTodo(int index, int itemIndex, int listNo) {
    if (listNo == 1) {
      note.noteWidgets[index]['data']['unchecked'].removeAt(itemIndex);
    } else if (listNo == 2) {
      note.noteWidgets[index]['data']['checked'].removeAt(itemIndex);
    }
    notifyListeners();
  }

  //Reminder functions
  void addReminder(DateTime time) {
    if (note.noteWidgets.isNotEmpty) {
      if (note.noteWidgets[0]['type'] != 'reminder') {
        note.noteWidgets.insert(0, NoteReminderModel(time: time).toMap());
        //print(note.noteWidgets[0]['data']);
        note.keywords.insert(0, 'Reminder');
        notifyListeners();
      }
    }
  }

  void updateReminder(DateTime time) {
    if (note.noteWidgets.isNotEmpty) {
      if (note.noteWidgets[0]['type'] == 'reminder') {
        note.noteWidgets[0] = NoteReminderModel(time: time).toMap();
        print(note.noteWidgets[0]['data']);
        notifyListeners();
      }
    }
  }

  void removeWidget(int index) {
    if (note.noteWidgets[index]['type'] == "imageURL") {
      db.deleteImage(note.noteWidgets[index]['data']);
    }
    note.noteWidgets.removeAt(index);
    note.keywords.removeAt(index);
    notifyListeners();
  }

  void display() {
    if (note.docId == null)
      db.createNote(note);
    else
      db.updateNote(note);
    print(note.noteWidgets);
  }

  void delete() async {
    if (note.docId != null) db.deleteNote(note.docId);
  }
}
