import 'package:chat_app/core/models/app_user.dart';
import 'package:chat_app/core/services/auth_services.dart';
import 'package:chat_app/core/services/database_service.dart';
import 'package:chat_app/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final _auth = AuthServices();
  final _db = DatabaseService();
  AppUser user = AppUser();
  bool isLoading = false;

  ProfileProvider() {
    getUser();
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("$e");
    }
  }

  getUser() async {
    isLoading = true;
    user = await _db.getUser(_auth.user!.uid);
    if (user.id != null) {
      debugPrint("user id ${user.id}");
    }
    isLoading = false;
    notifyListeners();
  }

  updateUser(BuildContext context) async {
    bool updated = await _db.updateUser(user);
    if (updated) {
      Dialogs.showSnackbar(context, "Updated Successfully");
      debugPrint("updated profile:${user.toJson()}");
    }
  }
}
