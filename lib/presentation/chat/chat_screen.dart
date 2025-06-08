import 'package:flutter/cupertino.dart';
import 'package:reconstructitapp/presentation/chat/chat_body.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return ChatBody();
  }
}
