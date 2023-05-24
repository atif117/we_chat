import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/helper/dialogs.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final _auth = AuthServices();

  signinWithGoogle(BuildContext context) async {
    Dialogs.showProgressBar(context);
    try {
      await _auth.signInWithGoogle(context).then((user) {
        Navigator.pop(context);
        if (user != null) {
          debugPrint("user name${user.user}");
          debugPrint("user add info${user.additionalUserInfo}");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        }
      });
    } on FirebaseAuthException catch (e) {
      debugPrint("$e");
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("$e");
    }
  }
}
