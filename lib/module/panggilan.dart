import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cometchat_calls_uikit/cometchat_calls_uikit.dart';
import 'package:deeptalk/home.dart';
import 'package:flutter/material.dart';

class Panggilan extends StatefulWidget {
  const Panggilan({super.key});

  @override
  State<Panggilan> createState() => _PanggilanState();
}

class _PanggilanState extends State<Panggilan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CometChatCallLogsWithDetails(
        callLogDetailConfiguration: CallLogDetailsConfiguration(),
        callLogsConfiguration: CallLogsConfiguration(
          title: 'Call',
          showBackButton: false,
          // errorStateText: 'No data!',
          // errorStateView: (context) {
          //   return const Text('No Data!');
          // },
          // onBack: () {
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => const Home()),
          //   );
          // },
          onError: (e) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.scale,
              title: 'Uppsss...',
              desc: 'No Calls Found!',
              btnOkOnPress: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ).show();
          },
        ),
      ),
    );
  }
}
