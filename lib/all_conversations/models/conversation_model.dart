class ConversationModel {
  final String username;
  final String userDp;
  final int unreadMessageCount;
  final String lastMessage;
  final String lastMessageTime;

  ConversationModel({
    required this.username,
    required this.userDp,
    required this.unreadMessageCount,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
