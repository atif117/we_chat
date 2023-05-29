import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final _auth = AuthServices();
  final _db = DatabaseService();
  final fb = FirebaseFirestore.instance;
  List<AppUser> users = [];
  List<AppUser> searchedUsers = [];
  bool isSearching = false;
  AppUser user = AppUser();

  // HomeProvider() {
  //   getUser();
  // }

  searching() {
    isSearching = !isSearching;
    searchedUsers.clear();
    notifyListeners();
  }

  searchUser(String val) async {
    searchedUsers.clear();
    for (var i in users) {
      if (i.name!.toLowerCase().contains(val.toLowerCase()) ||
          i.email!.toLowerCase().contains(val.toLowerCase())) {
        searchedUsers.add(i);
      }
    }

    debugPrint("searchedUsers: ${searchedUsers.length}");

    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllusers() {
    return FirebaseFirestore.instance
        .collection("app_user")
        .where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("$e");
    }
  }
}
