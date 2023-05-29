import 'dart:io';
import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/ui/widgets/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  bool isLogin = false;
  final fb = FirebaseAuth.instance;
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  User? user;
  AppUser appUser = AppUser();
  AppUser signupUser = AppUser();
  AuthServices() {
    init();
  }

  init() async {
    user = _auth.currentUser;
    if (user != null) {
      appUser = (await _dbService.getAppUser(user!.uid));
      isLogin = true;
      debugPrint("user login=$isLogin:id=>${user?.uid}");
    } else {
      isLogin = false;
      debugPrint("user login=$isLogin:id=>${user?.uid}");
    }
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    UserCredential result;
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      result = await FirebaseAuth.instance.signInWithCredential(credential);
      user = result.user;
      debugPrint("user name=>${user?.displayName}");
      debugPrint("user name=>${user?.phoneNumber}");
      appUser.id = user?.uid;

      signupUser = await _dbService.getUser(user?.uid);

      if (signupUser.id != null) {
        appUser = signupUser;
      } else if (signupUser.id == null) {
        appUser = appUser;
        appUser.name = user?.displayName;
        appUser.about = "Hey. I'm using We chat app";
        appUser.createdAt = time;
        appUser.id = user?.uid;
        appUser.lastSeen = time;
        appUser.profilePhoto = user?.photoURL;
        appUser.isOnline = false;
        appUser.email = user?.email;
        // appUser.pushToken = "";
        await _dbService.createAppUser(appUser);
      }
      // {
      //   appUser = (await _dbService.getAppUser(user!.uid));
      //   isLogin = true;
      // } else if (user == null) {
      //   appUser.name = user?.displayName;
      //   appUser.about = "";
      //   appUser.createdAt = DateTime.now().toString();
      //   appUser.id = user?.uid;
      //   appUser.lastSeen = DateTime.now().toString();
      //   appUser.profilePhoto = user?.photoURL;
      //   appUser.isOnline = false;
      //   appUser.pushToken = "";
      //   await _dbService.createAppUser(appUser);
      // }

      // Once signed in, return the UserCredential
      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("signInWithGoogle:$e");
      Dialogs.showSnackbar(
          context, "Something went wrong! check your internet connection");
      return null;
    }
    return result;
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
