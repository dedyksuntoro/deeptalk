import 'package:deeptalk/call_logs/call_logs_dashboard.dart';
import 'package:deeptalk/calls/calls_dashboard.dart';
import 'package:deeptalk/conversations_dashboard.dart';
import 'package:deeptalk/groups_dashboard.dart';
import 'package:deeptalk/home.dart';
import 'package:deeptalk/messages_dashboard.dart';
import 'package:deeptalk/shared/shared_dashboard.dart';
import 'package:deeptalk/users_dashboard.dart';
import 'package:deeptalk/utils/alert.dart';
import 'package:deeptalk/utils/module_card.dart';
import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

int _selectedIndex = 0;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 2, 10, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "UI Components",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Alert.showLoadingIndicatorDialog(context);
                          logout();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.power_settings_new_rounded,
                            color: cometChatTheme.palette.getAccent()))
                  ],
                ),
              ),
              ModuleCard(
                title: "Home",
                leading: Image.asset(
                  'assets/icons/conversations.png',
                  height: 40,
                  width: 40,
                ),
                description:
                    "Conversations module contains all available components for listing Conversation objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
              ModuleCard(
                title: "Conversations",
                leading: Image.asset(
                  'assets/icons/conversations.png',
                  height: 40,
                  width: 40,
                ),
                description:
                    "Conversations module contains all available components for listing Conversation objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConversationsDashboard()),
                  );
                },
              ),
              ModuleCard(
                leading: Image.asset(
                  'assets/icons/message.png',
                  height: 48,
                  width: 48,
                ),
                title: "Messages",
                description:
                    "Messages module contains all available components involving Message objects.\n"
                    "Components that helps you send, receive, view messages.\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MessagesDashboard()),
                  );
                },
              ),
              ModuleCard(
                title: "Users",
                leading: Image.asset(
                  'assets/icons/user-solid.png',
                  height: 40,
                  width: 40,
                ),
                description:
                    "Users module contains all available components involving User objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsersDashboard()),
                  );
                },
              ),
              ModuleCard(
                leading: Image.asset(
                  'assets/icons/group-chat.png',
                  height: 48,
                  width: 48,
                ),
                title: "Groups",
                description:
                    "Groups module contains all available components involving Group objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GroupsDashboard()),
                  );
                },
              ),
              ModuleCard(
                title: "Shared",
                leading: Image.asset(
                  'assets/icons/review.png',
                  height: 48,
                  width: 48,
                ),
                description:
                    "Shared module contains several reusable components that are divided into Resources and Views.\n"
                    "Resources are components that enhance some visual and functional aspect of a component  "
                    "and Views are core UI components which can collectively form a larger UI component\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SharedDashboard()),
                  );
                },
              ),
              ModuleCard(
                title: "Calls",
                leading: Image.asset(
                  'assets/icons/calling.png',
                  height: 48,
                  width: 48,
                ),
                description:
                    "Calls module contains all available components involving Call objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CallsDashboard()),
                  );
                },
              ),
              ModuleCard(
                title: "Call Logs",
                leading: Image.asset(
                  'assets/icons/audio-call.png',
                  height: 48,
                  width: 48,
                ),
                description:
                    "Call Logs module contains all available components involving CallLog objects\n"
                    "To explore the available components tap here\n",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CallLogsDashboard()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_rounded),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_rounded),
            label: 'Contact',
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await CometChatUIKit.logout();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
