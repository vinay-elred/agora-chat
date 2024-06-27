import 'dart:developer';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';

import '../utils/messaging_identifiers.dart';

class MessagingViewModel extends ChangeNotifier {
  MessagingViewModel(this.recipientUserId) {
    _addChatListener();
  }
  final String recipientUserId;
  List<ChatMessage> _messages = [];
  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void sendMessage(String textMessage) async {
    if (textMessage.isEmpty) {
      log("single recipientUserId $recipientUserId or message content error");
      return;
    }

    var data = ChatMessage.createTxtSendMessage(
      targetId: recipientUserId,
      content: textMessage,
    );
    final message = await ChatClient.getInstance.chatManager.sendMessage(data);
    _messages = [...messages, message];
    log("Sent message data ${message.toJson()}");
  }

  void _addChatListener() {
    ChatClient.getInstance.chatManager.addMessageEvent(
        MessagingIdentifiers.MESSAGE_SEND_HANDLER,
        ChatMessageEvent(
          onSuccess: (msgId, msg) {
            log("send message succeed");
          },
          onProgress: (msgId, progress) {
            log("send message succeed progress $progress");
          },
          onError: (msgId, msg, error) {
            log(
              "send message failed, code: ${error.code}, desc: ${error.description}",
            );
          },
        ));

    ChatClient.getInstance.chatManager.addEventHandler(
      MessagingIdentifiers.MESSAGE_RECEIVE_HANDLER,
      ChatEventHandler(onMessagesReceived: _onMessagesReceived),
    );
  }

  void _onMessagesReceived(List<ChatMessage> incomingMessages) {
    for (var msg in incomingMessages) {
      _messages = [...messages, msg];
      log(
        "receive message: ${msg.body.type}, from: ${msg.from}",
      );
    }
    notifyListeners();
  }

  @override
  void dispose() {
    ChatClient.getInstance.chatManager.removeEventHandler(
      MessagingIdentifiers.MESSAGE_RECEIVE_HANDLER,
    );
    ChatClient.getInstance.chatManager.removeMessageEvent(
      MessagingIdentifiers.MESSAGE_SEND_HANDLER,
    );
    super.dispose();
  }
}
