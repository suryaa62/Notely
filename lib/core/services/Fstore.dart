import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'dart:io';
import 'package:notes_app/core/models/userModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class Fstore {
  CollectionReference _usersRefrence;

  String _uid;

  Fstore() {
    init();
  }

  Future<void> init() async {
    _usersRefrence = await FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()),
            toFirestore: (user, _) => user.toMap());
  }

  //create user if it does not exist
  Future<void> createUser(String userID, String phoneNo) async {
    try {
      DocumentSnapshot doc = await _usersRefrence.doc(userID).get();
      if (!doc.exists)
        await _usersRefrence.doc(userID).set(UserModel(
            email: " ",
            phoneNo: phoneNo,
            userID: userID,
            imageURL: " ",
            name: " "));
      _uid = userID;
    } catch (e) {
      print(e.toString());
    }
  }

  //read user
  Future<UserModel> readUser() async {
    try {
      DocumentSnapshot doc = await _usersRefrence.doc(_uid).get();
      UserModel user = doc.data();
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  //update user
  Future<void> updateUser(Map<String, dynamic> map) async {
    try {
      await _usersRefrence.doc(_uid).update(map);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> uploadImage(String filePath, String cloudPath) async {
    if (!kIsWeb) {
      try {
        File image = File(filePath);
        await FirebaseStorage.instance.ref(_uid + cloudPath).putFile(image);
        String url = await FirebaseStorage.instance
            .ref(_uid + cloudPath)
            .getDownloadURL();
        return url;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<String> uploadImageWeb(XFile f, String cloudPath) async {
    if (kIsWeb) {
      try {
        await FirebaseStorage.instance.ref(_uid + cloudPath).putData(
            await f.readAsBytes(), SettableMetadata(contentType: 'image/jpeg'));
        String url = await FirebaseStorage.instance
            .ref(_uid + cloudPath)
            .getDownloadURL();
        return url;
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteImage(String ImageUrl) async {
    try {
      await FirebaseStorage.instance.refFromURL(ImageUrl).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createNote(NotesModel note) async {
    try {
      await _usersRefrence.doc(_uid).collection("notes").add(note.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateNote(NotesModel note) async {
    try {
      await _usersRefrence
          .doc(_uid)
          .collection("notes")
          .doc(note.docId)
          .set(note.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _usersRefrence.doc(_uid).collection("notes").doc(noteId).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getImageUrl() async {
    try {
      String url = await _usersRefrence
          .doc(_uid)
          .get()
          .then((value) => value.get(FieldPath(['imageURL'])));
      return url;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List> readAllNotes() async {
    try {
      QuerySnapshot notes =
          await _usersRefrence.doc(_uid).collection("notes").get();

      List allNotes = [];
      notes.docs.forEach((element) {
        allNotes.add(NotesModel.fromMap(element.data(), element.id));
        print(allNotes);
      });
      print(allNotes);
      return allNotes;
    } catch (e) {
      print("EXCEPTION CAUGHT");
      print(e.toString());
    }
  }

  Stream get notesStream {
    final Stream streamOfNotes =
        _usersRefrence.doc(_uid).collection("notes").snapshots();
    return streamOfNotes;
  }
}
