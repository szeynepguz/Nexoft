import 'package:flutter/material.dart';
import 'package:nexoft/model/user_model.dart';
import 'package:nexoft/service/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService userService = UserService();

  List<UserModel> users = [];
  bool isLoading = false;

  Future<void> getUserData() async {
    isLoading = true;
    notifyListeners();

    try {
      users = await userService.getData();
    } catch (e) {
      users = [];
    }
    isLoading = false;
    notifyListeners();
  }
}