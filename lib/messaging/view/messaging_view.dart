import 'package:flutter/material.dart';

import 'widgets/message_bubble.dart';
import 'widgets/messaging_field.dart';

class MessagingView extends StatelessWidget {
  const MessagingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: Column(
        children: [
          messageBuilder(),
          const MessagingField(),
        ],
      ),
    );
  }

  Widget messageBuilder() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MessageBubble(isSender: index % 2 == 0);
        },
      ),
    );
  }
}
