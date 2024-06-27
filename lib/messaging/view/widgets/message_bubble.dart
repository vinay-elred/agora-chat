import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.isSender});
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: isSender
              ? const EdgeInsets.all(10).copyWith(left: 100)
              : const EdgeInsets.all(10).copyWith(right: 100),
          decoration: BoxDecoration(
            borderRadius: isSender
                ? BorderRadius.circular(15).copyWith(
                    bottomRight: const Radius.circular(0),
                  )
                : BorderRadius.circular(15).copyWith(
                    topLeft: const Radius.circular(0),
                  ),
            color: isSender ? Colors.grey.shade300 : Colors.amber.shade300,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("Messageing data"),
              const Text("timestamp"),
              const SizedBox(height: 2),
              buildReceipts(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildReceipts() {
    if (!isSender) return const SizedBox.shrink();
    IconData icon = Icons.watch_later_rounded;
    if (true) icon = Icons.done;
    if (true) icon = Icons.done_all;
    return Icon(icon, size: 15);
  }
}
