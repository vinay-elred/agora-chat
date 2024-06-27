import 'package:agora_chat/all_conversations/models/conversation_model.dart';
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

  List<ConversationModel> _conversations = [];
  List<ConversationModel> get conversations => _conversations;
  set conversations(List<ConversationModel> newConversations) {
    _conversations = newConversations;
    notifyListeners();
  }

  void fetchConversations() async {
    isLoading = true;
    try {
      final agoraConv =
          await ChatClient.getInstance.chatManager.fetchConversation();

      for (var conv in agoraConv.data) {
        final unreadCount = await conv.unreadCount();
        final lastMessage = await conv.latestMessage();

        final conversation = ConversationModel(
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
