import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:deeptalk/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();

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
        });
  }

  @override
  Widget build(BuildContext context) {
    String customUidLogin = "";

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(fontSize: 30),
              ),
              TextFormField(
                onChanged: (val) {
                  customUidLogin = val;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UID',
                  hintText: 'UID',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Flexible(
                          child: Text('Need account?'),
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CreateAccount()));
                            },
                            child: const Text(
                              ' Create',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black);
                        CometChatUIKit.login(
                          customUidLogin,
                          onSuccess: (User user) {
                            EasyLoading.dismiss();
                            // debugPrint(
                            //     "User logged in successfully  ${user.name}");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CometChatUsersWithMessages()));
                          },
                          onError: (CometChatException e) {
                            // debugPrint(
                            //     "Login failed with exception: ${e.message}");
                            EasyLoading.dismiss();
                            AwesomeDialog(
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              title: 'Login Failed',
                              desc: 'UID Not Found',
                              btnOkOnPress: () {},
                            ).show();
                          },
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
