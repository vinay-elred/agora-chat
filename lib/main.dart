import 'package:agora_chat/all_conversations/view/all_conversation_view.dart';
import 'package:agora_chat/all_conversations/view_model/all_conversation_view_model.dart';
import 'package:agora_chat/authentication/view/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'authentication/view_model/auth_view_model.dart';
import 'core/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ChatService.initAgoraChat();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(),
        ),
        ChangeNotifierProvider<AllConversationViewModel>(
          create: (context) => AllConversationViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Consumer<AuthViewModel>(builder: (context, vm, child) {
            if (vm.geCurrentUserId != null) {
              return const AllConversationsView();
            }
            return const LoginScreen();
          }),
        ),
      ),
    );
  }
}
