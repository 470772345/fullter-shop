import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class LiveChatArea extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController? controller;

  const LiveChatArea({
    Key? key,
    required this.messages,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      constraints: BoxConstraints(
        maxHeight: 4 * 36.0, // 每条消息36高度，最多4条
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${msg.user}: ',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                    ),
                  ),
                  TextSpan(
                    text: msg.content,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}