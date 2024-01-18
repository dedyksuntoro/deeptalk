import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

class Kontak extends StatefulWidget {
  const Kontak({super.key});

  @override
  State<Kontak> createState() => _KontakState();
}

class _KontakState extends State<Kontak> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CometChatUsersWithMessages(
      usersConfiguration:
          UsersConfiguration(title: 'Contact', showBackButton: false),
    ));
  }
}
