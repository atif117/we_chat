import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/ui/screens/home/home_provider.dart';
import 'package:chat_app/ui/screens/profile/profile_screen.dart';
import 'package:chat_app/ui/widgets/chat_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // List<AppUser> users = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: model.isSearching
                ? TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "Search..."),
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        model.searchUser(val);
                      }
                    },
                  )
                : const Text('We Chat'),
            leading: const Icon(
              CupertinoIcons.home,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    model.searching();
                  },
                  icon: Icon(model.isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                  },
                  icon: const Icon(Icons.more_vert))
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
          body: model.searchedUsers.length <= 0 && model.isSearching
              ? const Center(
                  child: Text("User not found!"),
                )
              : StreamBuilder(
                  stream: model.getAllusers(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        model.users = snapshot.data!.docs
                            .map((e) => AppUser.fromJson(e.data(), e.id))
                            .toList();
                        // print("length of users ${users.length}");

                        if (model.users.isNotEmpty) {
                          return ListView.builder(
                              itemCount: model.isSearching
                                  ? model.searchedUsers.length
                                  : model.users.length,
                              itemBuilder: (context, index) {
                                return ChatCard(
                                  user: model.isSearching
                                      ? model.searchedUsers[index]
                                      : model.users[index],
                                );
                              });
                        } else {
                          return const Center(
                              child: Text("No connections found"));
                        }
                    }
                  },
                ),
        ),
      ),
    );
  }
}
