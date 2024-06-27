import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

class MessageTypeWidget extends StatelessWidget {
  const MessageTypeWidget({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final msgType = message.body.type;
    if (msgType == MessageType.TXT) {
      ChatTextMessageBody body = message.body as ChatTextMessageBody;
      return Text(body.content);
    }
    return const SizedBox.shrink();
  }
}
