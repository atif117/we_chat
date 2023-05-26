// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/ui/widgets/dialogs.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final _auth = AuthServices();

  signinWithGoogle(BuildContext context) async {
    Dialogs.showProgressBar(context);
    try {
      UserCredential? userCredential = await _auth.signInWithGoogle(context);
      if (userCredential != null) {
        debugPrint("user name${userCredential.user}");
        debugPrint("user add info${userCredential.additionalUserInfo}");
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("$e");
    }
    return null;
  }
}
