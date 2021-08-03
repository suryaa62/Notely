import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/core/models/userModel.dart';

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
}
