import 'package:agora_chat/sourav_modules/authentication/const/agora_chat_config.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newVal) {
    _isLoading = newVal;
    notifyListeners();
  }

  void initializeAgoraChat() async {
    ChatOptions options = ChatOptions(
      appKey: AgoraChatConfig.appKey,
      autoLogin: false,
    );
    await ChatClient.getInstance.init(options);
    await ChatClient.getInstance.startCallback();
  }

  Future<bool> login(String username) async {
    isLoading = true;

    if (username.isEmpty) {
      isLoading = false;
      return false;
    }

    try {
      await ChatClient.getInstance
          .login(username, AgoraChatConfig.userPwd, true);
      return true;
    } catch (error) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
