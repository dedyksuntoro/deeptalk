import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:deeptalk/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      builder: EasyLoading.init(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeeeeee),
        primarySwatch: Colors.blue,
      ),
      home: Login(
        key: CallNavigationContext.navigatorKey,
      ),
    );
  }
}
