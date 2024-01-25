import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:deeptalk/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
  cometChatInit();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: CallNavigationContext.navigatorKey,
      title: 'DeepTalk',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffeeeeee),
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

cometChatInit() {
  /**
    *CometChatUIKit should be initialized at the start of application. No need to initialize it again
    **/
  UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
        ..callingExtension = CometChatCallingExtension()
        ..subscriptionType = CometChatSubscriptionType.allUsers
        ..autoEstablishSocketConnection = true
        ..region = "us" //Replace with your region
        ..appId = "251185a69a8e9aac" //replace with your app Id
        ..authKey = "6413f67610b586c43f66f4494e5cc05d4a05770a"
        ..extensions = CometChatUIKitChatExtensions
            .getDefaultExtensions() //replace this with empty array you want to disable all extensions
      ) //replace with your auth Key
      .build();

  CometChatUIKit.init(
    uiKitSettings: uiKitSettings,
    onSuccess: (String successMessage) {
      debugPrint("Initialization completed successfully  $successMessage");
    },
    onError: (CometChatException e) {
      debugPrint("Initialization failed with exception: ${e.message}");
    },
  );
}
