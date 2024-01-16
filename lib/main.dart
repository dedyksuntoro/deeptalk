import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:deeptalk/login_with_uid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeepTalk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeeeeee),
        primarySwatch: Colors.blue,
      ),
      home: LoginWithUID(
        key: CallNavigationContext.navigatorKey,
      ),
    );
  }
}
