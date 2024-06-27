import 'package:flutter/material.dart';

class MessagingField extends StatefulWidget {
  const MessagingField({super.key});

  @override
  State<MessagingField> createState() => _MessagingFieldState();
}

class _MessagingFieldState extends State<MessagingField> {
  final textController = TextEditingController();
  bool enableSend = false;

  @override
  void initState() {
    super.initState();
    addListener();
  }

  void addListener() {
    textController.addListener(() {
      final state = textController.text.trim().isNotEmpty;
      if (state != enableSend) {
        enableSend = state;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).copyWith(top: 5, bottom: 30),
      child: TextField(
        controller: textController,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Message here...",
          contentPadding: const EdgeInsets.all(15),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: enableSend ? Colors.blue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
