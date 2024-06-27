import 'package:agora_chat/messaging/view/messaging_view.dart';
import 'package:flutter/material.dart';

import 'core/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ChatService.initAgoraChat();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MessagingView(),
    );
  }
}
