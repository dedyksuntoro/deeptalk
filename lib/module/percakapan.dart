import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

class Percakapan extends StatefulWidget {
  const Percakapan({super.key});

  @override
  State<Percakapan> createState() => _PercakapanState();
}

class _PercakapanState extends State<Percakapan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CometChatConversationsWithMessages(
        startConversationConfiguration: ContactsConfiguration(),
        conversationsConfiguration: const ConversationsConfiguration(
          title: 'Chat',
          showBackButton: false,
        ),
      ),
    );
  }
}
