import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:deeptalk/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    String customNameRegister = "";
    String customUidRegister = "";

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'REGISTER',
                style: TextStyle(fontSize: 30),
              ),
              TextFormField(
                onChanged: (val) {
                  customNameRegister = val;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Name',
                ),
              ),
              TextFormField(
                onChanged: (val) {
                  customUidRegister = val;
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
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () {
                        EasyLoading.show(
                            status: 'loading...',
                            maskType: EasyLoadingMaskType.black);
                        CometChatUIKit.createUser(
                          User(
                              name: customNameRegister, uid: customUidRegister),
                          onSuccess: (User user) {
                            // debugPrint("User created successfully ${user.name}");
                            EasyLoading.dismiss();
                            AwesomeDialog(
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              title: 'Register Successfully',
                              desc: 'User ${user.name} Created',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          },
                          onError: (CometChatException e) {
                            // debugPrint(
                            //     "Creating new user failed with exception: ${e.message}");
                            EasyLoading.dismiss();
                            AwesomeDialog(
                              dismissOnBackKeyPress: false,
                              dismissOnTouchOutside: false,
                              context: context,
                              dialogType: DialogType.noHeader,
                              animType: AnimType.bottomSlide,
                              title: 'Register Failed',
                              desc: 'UID Alredy Registered!',
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
