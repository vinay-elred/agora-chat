import 'package:agora_chat_sdk/agora_chat_sdk.dart';

class ChatService {
  ChatService._();

  static const String _appKey = '611171021#1358234';

  static Future<void> initAgoraChat() async {
    ChatOptions options = ChatOptions(
      appKey: _appKey,
      autoLogin: false,
    );
    await ChatClient.getInstance.init(options);
    await ChatClient.getInstance.startCallback();
  }
}
