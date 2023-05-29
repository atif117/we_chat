import 'package:chat_app/main.dart';
import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/profile/profile_provider.dart';
import 'package:chat_app/ui/widgets/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: Consumer<ProfileProvider>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                CupertinoIcons.back,
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10.0.h),
            child: FloatingActionButton.extended(
              onPressed: () async {
                Dialogs.showProgressBar(context);
                await model.signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen()));
                });
                // model.signOut();
              },
              backgroundColor: Colors.redAccent,
              icon: const Icon(Icons.logout),
              label: const Text("Log Out"),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: SingleChildScrollView(
              child: model.isLoading
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Stack(
                            children: [
                              CircleAvatar(
                                  radius: 45.r,
                                  backgroundImage: model.user.profilePhoto !=
                                          null
                                      ? NetworkImage(model.user.profilePhoto!)
                                      : null,
                                  child: model.user.profilePhoto != null
                                      ? Container()
                                      : const Icon(CupertinoIcons.person)),
                              Positioned(
                                right: 10,
                                bottom: 6,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.edit, size: 17),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            model.user.email.toString(),
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.black54),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(children: [
                              TextFormField(
                                initialValue: model.user.name,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    model.user.name = val;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter name";
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    hintText: "e.g. John Doe",
                                    label: const Text("Name")),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              TextFormField(
                                initialValue: model.user.about,
                                onChanged: (val) {
                                  if (val.isNotEmpty) {
                                    model.user.about = val;
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter about";
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      CupertinoIcons.info,
                                      color: Colors.blue,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    hintText: "e.g. Feeling good",
                                    label: const Text("About")),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                minimumSize:
                                    Size(mq.width * 0.5, mq.height * 0.06),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  model.updateUser(context);
                                }
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              ),
                              label: const Text("Update"))
                        ]),
            ),
          ),
        ),
      ),
    );
  }
}
