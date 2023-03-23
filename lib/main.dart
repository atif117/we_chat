import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/constant/styles.dart';
import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size mq;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'We Chat',
          theme: ThemeData(
              appBarTheme: AppBarTheme(
            centerTitle: true,
            titleTextStyle: appBarStyle,
            iconTheme: const IconThemeData(color: kBlack),
            backgroundColor: kWhite,
            elevation: 1,
          )),
          home: const LogInScreen(),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
