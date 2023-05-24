import 'package:chat_app/ui/screens/home/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('We Chat'),
            leading: const Icon(
              CupertinoIcons.home,
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10.0.h),
            child: FloatingActionButton(
              onPressed: () {
                model.signOut();
              },
              child: const Icon(Icons.add_comment_rounded),
            ),
          ),
          body: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
