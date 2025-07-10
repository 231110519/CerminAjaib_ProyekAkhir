// screens/Home/chat_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/chat_provider.dart';

class ChatPage extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const ChatPage({
    Key? key,
    required this.doctorName,
    required this.doctorImage,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();

  String formatChatTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));
    final timeFormat = DateFormat.Hm();

    if (dateTime.isAfter(today)) {
      return 'Hari ini, ${timeFormat.format(dateTime)}';
    } else if (dateTime.isAfter(yesterday)) {
      return 'Kemarin, ${timeFormat.format(dateTime)}';
    } else {
      final dateFormat = DateFormat('d MMMM yyyy', 'id');
      return '${dateFormat.format(dateTime)}, ${timeFormat.format(dateTime)}';
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Provider.of<ChatProvider>(
        context,
        listen: false,
      ).sendMessage(widget.doctorName, text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<ChatProvider>().getMessages(
      widget.doctorName,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.doctorImage),
              radius: 16,
            ),
            const SizedBox(width: 8),
            Text(widget.doctorName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['text']),
                      ),
                      Text(
                        formatChatTime(message['timestamp']),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
