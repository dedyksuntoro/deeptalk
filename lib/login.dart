
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:deeptalk/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? valueUID;

  final storage = new FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future readSecureData(String key) async {
    valueUID = await storage.read(key: key) ?? 'null';
  }

  Future writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  void initState() {
    super.initState();
    // cometChatInit();

    readSecureData('UID').then((value) {
      if (valueUID != 'null') {
        CometChatUIKit.login(
          valueUID.toString(),
          onSuccess: (User user) {
            // debugPrint(
            //     "User logged in successfully  ${user.name}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CometChatConversationsWithMessages(
                  conversationsConfiguration: const ConversationsConfiguration(
                    showBackButton: false,
                    title: 'DeepTalk',
                  ),
                  startConversationConfiguration: ContactsConfiguration(
                    contactsStyle: const ContactsStyle(
                      selectedTabColor: Colors.transparent,
                      tabBorderRadius: 0,
                      tabColor: Colors.black,
                    ),
                  ),
                ),
              ),
            );
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
              title: 'Login Failed $valueUID',
              desc: 'UID Not Found',
              btnOkOnPress: () {},
            ).show();
          },
        );
      }
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
                            // debugPrint(
                            //     "User logged in successfully  ${user.name}");
                            EasyLoading.dismiss();
                            writeSecureData('UID', user.uid).then((value) {
                              readSecureData('UID').then((value) {
                                if (valueUID != 'null') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CometChatConversationsWithMessages(
                                          conversationsConfiguration:
                                              const ConversationsConfiguration(
                                            showBackButton: false,
                                            title: 'DeepTalk',
                                          ),
                                          startConversationConfiguration:
                                              ContactsConfiguration(
                                            contactsStyle: const ContactsStyle(
                                              selectedTabColor:
                                                  Colors.transparent,
                                              tabBorderRadius: 0,
                                              tabColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ));
                                } else {
                                  AwesomeDialog(
                                    dismissOnBackKeyPress: false,
                                    dismissOnTouchOutside: false,
                                    context: context,
                                    dialogType: DialogType.noHeader,
                                    animType: AnimType.bottomSlide,
                                    title: 'Local Storage Failed',
                                    desc: 'Failed Process Local Storage',
                                    btnOkOnPress: () {},
                                  ).show();
                                }
                              });
                            });
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
