import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/ui/screens/home/home_provider.dart';
import 'package:chat_app/ui/widgets/chat_card.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  List<AppUser> users = [];

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
          body: StreamBuilder(
            stream: model.fb.collection("app_user").snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  final users = snapshot.data!.docs
                      .map((e) => AppUser.fromJson(e.data(), e.id))
                      .toList();

                  if (users.isNotEmpty) {
                    return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            user: users[index],
                          );
                        });
                  } else {
                    return const Center(child: Text("No connections found"));
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
