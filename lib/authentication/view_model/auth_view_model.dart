import 'dart:developer';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newVal) {
    _isLoading = newVal;
    notifyListeners();
  }

  Future<bool> login(String username) async {
    if (username.isEmpty) return false;

    isLoading = true;
    try {
      await ChatClient.getInstance.login(username, '12345', true);
      return true;
    } catch (error) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<bool> signOut() async {
    try {
      await ChatClient.getInstance.logout(true);
      log("sign out succeed");
      return true;
    } catch (e) {
      log("sign out failed, code: $e");
      return false;
    }
  }
}
