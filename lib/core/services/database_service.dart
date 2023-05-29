import 'package:chat_app/core/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Future<AppUser> getUser(id) async {
    debugPrint('@getUser: id: $id');
    try {
      final snapshot = await _db.collection("app_user").doc(id).get();
      if (snapshot.exists) {
        debugPrint('Client Data: ${snapshot.data()}');
        return AppUser.fromJson(snapshot.data(), snapshot.id);
      } else {
        return AppUser();
      }
    } catch (e) {
      debugPrint("Exception @DatabaseService/getUser:$e");
      return AppUser();
    }
  }

  Future<AppUser> getAppUser(id) async {
    debugPrint('@getAppUser: id: $id');
    try {
      final snapshot = await _db.collection('app_user').doc(id).get();

      if (snapshot.exists) {
        debugPrint('Client Data: ${snapshot.data()}');
        return AppUser.fromJson(snapshot.data(), snapshot.id);
      } else {
        return AppUser();
      }
    } catch (e, s) {
      debugPrint('Exception @DatabaseService/getAppUser');
      debugPrint(s.toString());
      return AppUser();
    }
  }

  createAppUser(AppUser user) async {
    debugPrint("@createAppUser: id: ${user.id}");
    try {
      await _db.collection('app_user').doc(user.id).set(user.toJson());
    } catch (e) {
      debugPrint('Exception @DatabaseService/createAppUser');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateUser(AppUser user) async {
    debugPrint("@updateUser: id: ${user.id}");
    try {
      await _db.collection('app_user').doc(user.id).update(user.toJson());
      return true;
    } catch (e) {
      debugPrint('Exception @DatabaseService/updateUser');
      debugPrint(e.toString());
      return false;
    }
  }
}
