import 'package:chat_app/core/constant/colors.dart';
import 'package:chat_app/core/constant/styles.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => {_initializeFirebase(), runApp(const MyApp())});
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
          home: const SplashScreen(),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
