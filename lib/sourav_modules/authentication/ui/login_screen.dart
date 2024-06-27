import 'package:agora_chat/sourav_modules/authentication/const/agora_chat_config.dart';
import 'package:agora_chat/sourav_modules/authentication/view_model/auth_view_model.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    try {
      context.read<AuthViewModel>().initializeAgoraChat();
    } catch (e) {
      _showMessage(e.toString());
    }
  }

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
                        if (success) {
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
