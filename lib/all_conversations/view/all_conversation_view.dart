import 'package:agora_chat/all_conversations/view/widgets/conversation_item.dart';
import 'package:agora_chat/all_conversations/view_model/all_conversation_view_model.dart';
import 'package:agora_chat/authentication/view/login_screen.dart';
import 'package:agora_chat/authentication/view_model/auth_view_model.dart';
import 'package:agora_chat/extensions/context_extensions.dart';
import 'package:agora_chat/all_conversations/models/conversation_model.dart';
import 'package:agora_chat/messaging/view/messaging_view.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AllConversationsView extends StatefulWidget {
  const AllConversationsView({super.key});

  @override
  State<AllConversationsView> createState() => _AllConversationsViewState();
}

class _AllConversationsViewState extends State<AllConversationsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AllConversationViewModel>().fetchConversations();
    });
  }

  final _conv = [
    ConversationModel(
      username: 'sourav',
      userDp:
          'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109',
      unreadMessageCount: 2,
      lastMessage: 'This is last message',
      lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
    ),
    ConversationModel(
      username: 'vinay',
      userDp:
          'https://gravatar.com/avatar/27205e5c51cb03f862138b22bcb5dc20f94a342e744ff6df1b8dc8af3c865109',
      unreadMessageCount: 2,
      lastMessage: 'This is last message',
      lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AllConversationViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Recent Chats'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () async {
                final success = await context.read<AuthViewModel>().signOut();

                if (success) {
                  context.pushUntilRoute(const LoginScreen());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Logged out successfully!')));
                }
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Selector<AllConversationViewModel, bool>(
          selector: (ctx, vm) => vm.isLoading,
          builder: (context, isLoading, child) => isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _conv.length,
                  itemBuilder: (context, index) {
                    ConversationModel conversation = _conv[index];
                    return InkWell(
                      onTap: () => context.pushMaterialRoute(
                        MessagingView(recipientUserId: conversation.username),
                      ),
                      child: ConversationItem(conversation: conversation),
                    );
                  },
                ),
        ));
  }
}
