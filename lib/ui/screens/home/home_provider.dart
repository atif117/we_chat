import 'package:chat_app/core/services/auth_services.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final _auth = AuthServices();

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("$e");
    }
  }
}
