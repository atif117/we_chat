import 'package:chat_app/core/constant/strings.dart';
import 'package:chat_app/core/constant/styles.dart';
import 'package:chat_app/ui/screens/auth/login/login_provider.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Welcom to We Chat'),
          ),
          body: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: mq.height * .15,
                right: _isAnimate ? mq.width * .25 : -mq.width * .5,
                width: mq.width * .5,
                child: Image.asset(
                  '$staticAsset/app-icon.png',
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              Positioned(
                bottom: mq.height * .15,
                left: mq.width * .05,
                width: mq.width * .9,
                height: mq.height * .06,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 182, 247, 184),
                      shape: const StadiumBorder(),
                      elevation: 1),
                  onPressed: () {
                    model.signinWithGoogle(context);
                  },
                  icon: Image.asset(
                    '$staticAsset/google.png',
                    height: mq.height * 0.04,
                  ),
                  label: RichText(
                    text: TextSpan(
                      style: appBarStyle,
                      children: [
                        const TextSpan(text: 'Login with '),
                        TextSpan(
                          text: 'Google',
                          style:
                              appBarStyle.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
