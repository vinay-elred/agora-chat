import 'package:agora_chat/all_conversations/models/conversation_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  final ConversationModel conversation;

  const ConversationItem({Key? key, required this.conversation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          conversation.userDp,
        ),
      ),
      title: Text(conversation.username),
      subtitle: Text(
        conversation.lastMessage,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('hh:mm a').format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(conversation.lastMessageTime),
              ),
            ),
          ),
          if (conversation.unreadMessageCount > 0)
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text(
                conversation.unreadMessageCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
