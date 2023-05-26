import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final _auth = AuthServices();
  final _db = DatabaseService();
  final fb = FirebaseFirestore.instance;
  List<AppUser> users = [];

  // HomeProvider() {
  //   getUser();
  // }

  // getUser() async {
  //   users = await _db.getUser();
  //   if (users.isNotEmpty) {
  //     print("app user ${users.length}");
  //   }
  //   notifyListeners();
  // }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("$e");
    }
  }
}
