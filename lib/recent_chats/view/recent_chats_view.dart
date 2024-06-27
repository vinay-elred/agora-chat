import 'package:agora_chat/authentication/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentChatsView extends StatelessWidget {
  const RecentChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                context.read<AuthViewModel>().signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
