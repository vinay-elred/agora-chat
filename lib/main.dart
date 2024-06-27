import 'package:agora_chat/sourav_modules/authentication/ui/login_screen.dart';
import 'package:agora_chat/sourav_modules/authentication/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: LoginScreen()),
      ),
    );
  }
}
