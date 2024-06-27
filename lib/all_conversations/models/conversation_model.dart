class ConversationModel {
  final String username;
  final String userDp;
  final int unreadMessageCount;
  final String lastMessage;
  final String lastMessageTime;

  ConversationModel({
    required this.username,
    this.userDp =
        'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109',
    required this.unreadMessageCount,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
