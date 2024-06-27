import 'package:agora_chat/extensions/context_extensions.dart';
import 'package:agora_chat/recent_chats/view/recent_chats_view.dart';
import 'package:agora_chat/authentication/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../messaging/view/messaging_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Chat Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            Selector<AuthViewModel, bool>(
              selector: (ctx, vm) => vm.isLoading,
              builder: (context, isLoading, child) => isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        final success =
                            await vm.login(_usernameController.text.trim());
                        if (success && mounted) {
                          context.pushMaterialRoute(const MessagingView());
                          _showMessage("Logged in successfully");
                        } else {
                          _showMessage("something went wrong");
                        }
                      },
                      child: const Text('Login'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
