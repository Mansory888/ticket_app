import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api/question_service.dart';
import '../question_view/question_view.dart';
import '../topic_screen/topic_list_screen.dart';
import 'package:ticket_app/views/settings_screen/settings_screen.dart';
import 'package:ticket_app/views/main_screen/main_screen_body.dart';
import 'package:ticket_app/models/user.dart';
import 'package:ticket_app/models/user_response.dart';
import '../../services/api/user_service.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidget();
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Empty'),
    );
  }
}

class _MainScreenWidget extends State<MainScreenWidget> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [const EmptyWidget(), const EmptyWidget()];
  UserResponse? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    UserResponse userData = await getUserData();
    setState(() {
      user = userData;
      _widgetOptions = [
        MainScreenBodyWidget(
          user: user,
        ),
        SettingsScreenWidget(user: user),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
        automaticallyImplyLeading: false,
        elevation: 0,
        shadowColor: Colors.transparent,
        toolbarHeight: 10.0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).Home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).Settings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
