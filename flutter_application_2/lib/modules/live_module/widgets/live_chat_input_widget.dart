import 'package:flutter/material.dart';

class LiveChatInput extends StatefulWidget {
  final void Function(String text) onSend;

  const LiveChatInput({Key? key, required this.onSend}) : super(key: key);

  @override
  State<LiveChatInput> createState() => _LiveChatInputState();
}

class _LiveChatInputState extends State<LiveChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withAlpha((0.08 * 255).toInt()),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Say hi...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withAlpha((0.9 * 255).toInt()),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
            onPressed: _handleSend,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}