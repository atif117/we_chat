import 'package:chat_app/core/constant/strings.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = locator<AuthServices>();

  @override
  // ignore: override_on_non_overriding_member

  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

      if (_authService.isLogin) {
        debugPrint("User already Login");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        debugPrint("User not Login");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LogInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .25,
            right: mq.width * .25,
            width: mq.width * .5,
            child: Image.asset(
              '$staticAsset/app-icon.png',
              height: 100.h,
              width: 100.w,
            ),
          ),
          Positioned(
              top: mq.height * .45,
              left: mq.width * .05,
              width: mq.width * .9,
              height: mq.height * .06,
              child: const Center(child: Text("Welcome to We Chat"))),
        ],
      ),
    );
  }
}
