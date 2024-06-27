class Conversation {
  final String username;
  final String userDp;
  final int unreadMessageCount;
  final String lastMessage;
  final String lastMessageTime;

  Conversation({
    required this.username,
    required this.userDp,
    required this.unreadMessageCount,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
