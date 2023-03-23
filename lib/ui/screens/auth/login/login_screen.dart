import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/constant/strings.dart';
import 'package:chat_app/core/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcom to We Chat'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .15,
            left: mq.width * .25,
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
              onPressed: () {},
              icon: Image.asset(
                '$staticAsset/google.png',
                height: mq.height * 0.04,
              ),
              label: RichText(
                text: TextSpan(
                  style: appBarStyle,
                  children: [
                    const TextSpan(text: 'Sign In with '),
                    TextSpan(
                      text: 'Google',
                      style: appBarStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
