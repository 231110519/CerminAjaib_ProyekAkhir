import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final Map<String, List<Map<String, dynamic>>> _chatMessages = {};

  List<Map<String, dynamic>> getMessages(String doctorName) {
    return _chatMessages[doctorName] ?? [];
  }

  void sendMessage(String doctorName, String text) {
    final message = {'text': text, 'timestamp': DateTime.now()};

    if (_chatMessages.containsKey(doctorName)) {
      _chatMessages[doctorName]!.add(message);
    } else {
      _chatMessages[doctorName] = [message];
    }

    notifyListeners();
  }

  void clearChat(String doctorName) {
    _chatMessages.remove(doctorName);
    notifyListeners();
  }
}
