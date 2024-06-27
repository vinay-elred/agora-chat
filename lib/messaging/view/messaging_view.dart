import 'package:agora_chat/messaging/view_model/messaging_view_model.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/message_bubble.dart';
import 'widgets/messaging_field.dart';

class MessagingView extends StatelessWidget {
  const MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MessagingViewModel('vinay'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messaging'),
        ),
        body: Column(
          children: [
            messageBuilder(),
            const MessagingField(),
          ],
        ),
      ),
    );
  }

  Widget messageBuilder() {
    return Expanded(
      child: Selector<MessagingViewModel, List<ChatMessage>>(
        selector: (p0, p1) => p1.messages,
        builder: (context, messages, child) {
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final currentUserId = ChatClient.getInstance.currentUserId;
              final isMe = message.from == currentUserId;
              return MessageBubble(isSender: isMe, message: message);
            },
          );
        },
      ),
    );
  }
}
