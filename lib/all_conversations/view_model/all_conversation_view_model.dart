import 'package:agora_chat/all_conversations/models/conversation.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

class AllConversationViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool newValue) {
    _isLoading = isLoading;
    notifyListeners();
  }

  // List<ChatConversation> _conversations = [];
  // List<ChatConversation> get conversations => _conversations;

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;
  set conversations(List<Conversation> newConversations) {
    _conversations = newConversations;
    notifyListeners();
  }

  void fetchConversations() async {
    isLoading = true;
    try {
      List<ChatConversation> agoraConv =
          await ChatClient.getInstance.chatManager.loadAllConversations();

      for (var conv in agoraConv) {
        final unreadCount = await conv.unreadCount();
        final lastMessage = await conv.latestMessage();
        final conversation = Conversation(
          username: lastMessage!.from!,
          userDp: '',
          unreadMessageCount: unreadCount,
          lastMessage: (lastMessage.body as ChatTextMessageBody).content,
          lastMessageTime: lastMessage.localTime.toString(),
        );
        _conversations.add(conversation);
      }
    } catch (error) {
      print('Failed to load conversations: $error');
    } finally {
      isLoading = false;
    }
  }
}
