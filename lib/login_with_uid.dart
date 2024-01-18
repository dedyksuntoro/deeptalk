import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:deeptalk/dashboard.dart';
import 'package:deeptalk/home.dart';
import 'package:deeptalk/sign_up.dart';
import 'package:deeptalk/utils/alert.dart';
import 'package:deeptalk/utils/constants.dart';
import 'package:deeptalk/utils/demo_meta_info_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

class LoginWithUID extends StatefulWidget {
  const LoginWithUID({Key? key}) : super(key: key);

  @override
  _LoginWithUIDState createState() => _LoginWithUIDState();
}

class _LoginWithUIDState extends State<LoginWithUID> {
  String customUidLogin = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    //CometChat SDk should be initialized at the start of application. No need to initialize it again
    // AppSettings appSettings = (AppSettingsBuilder()
    //       ..subscriptionType = CometChatSubscriptionType.allUsers
    //       ..region = CometChatConstants.region
    //       ..autoEstablishSocketConnection = true)
    //     .build();
    //
    // CometChat.init(CometChatConstants.appId, appSettings,
    //     onSuccess: (String successMessage) {
    //   debugPrint("Initialization completed successfully  $successMessage");
    // }, onError: (CometChatException excep) {
    //   debugPrint("Initialization failed with exception: ${excep.message}");
    // });

    makeUISettings();

    //initialization end
  }

  makeUISettings() {
    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
          ..subscriptionType = CometChatSubscriptionType.allUsers
          ..region = CometChatConstants.region
          ..autoEstablishSocketConnection = true
          ..appId = CometChatConstants.appId
          ..authKey = CometChatConstants.authKey
          ..callingExtension = CometChatCallingExtension()
          ..extensions = CometChatUIKitChatExtensions.getDefaultExtensions()
          ..aiFeature = [
            AISmartRepliesExtension(),
            AIConversationStarterExtension(),
            AIAssistBotExtension(),
            AIConversationSummaryExtension()
          ])
        .build();

    CometChatUIKit.init(
      uiKitSettings: uiKitSettings,
      onSuccess: (successMessage) {
        // try {
        //   CometChat.setDemoMetaInfo(jsonObject: {
        //     "name": DemoMetaInfoConstants.name,
        //     "type": DemoMetaInfoConstants.type,
        //     "version": DemoMetaInfoConstants.version,
        //     "bundle": DemoMetaInfoConstants.bundle,
        //     "platform": DemoMetaInfoConstants.platform,
        //   });
        // } catch (e) {
        //   if (kDebugMode) {
        //     debugPrint("setDemoMetaInfo ended with error");
        //   }
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Welcome !",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Kindly enter UID to proceed",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 46,
                  child: TextFormField(
                    onChanged: (val) {
                      customUidLogin = val;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UID',
                      hintText: 'UID',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New to cometchat? "),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()));
                        },
                        child: const Text("CREATE NEW",
                            style: TextStyle(
                                //decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue)))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        backgroundColor: Colors.blue,
        onPressed: () {
          if (customUidLogin.isNotEmpty) {
            loginUser(customUidLogin, context);
          }
        },
        label: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Login User function must pass userid and authkey should be used only while developing
  loginUser(String userId, BuildContext context) async {
    Alert.showLoadingIndicatorDialog(context);
    // ToastContext().init(context); //Replace with name and uid of user
    User? _user = await CometChat.getLoggedInUser();
    try {
      if (_user != null) {
        await CometChatUIKit.logout();
      }
    } catch (_) {}

    await CometChatUIKit.login(userId, onSuccess: (User loggedInUser) {
      debugPrint("Login Successful : $loggedInUser");
      _user = loggedInUser;
    }, onError: (CometChatException e) {
      debugPrint("Login failed with exception:  ${e.message}");
      // Toast.show("Login failed",
      //     duration: Toast.lengthShort, gravity: Toast.bottom);
    });

    Navigator.of(context).pop();

    //if login is successful
    if (_user != null) {
      //USERID = _user!.uid;
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }
}
