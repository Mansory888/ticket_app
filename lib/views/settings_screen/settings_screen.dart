import 'package:flutter/material.dart';
import 'package:ticket_app/models/user.dart';
import '../../generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api/question_service.dart';
import '../question_view/question_view.dart';
import '../topic_screen/topic_list_screen.dart';
import '../../services/api/user_service.dart';
import 'package:ticket_app/main.dart';
import 'package:provider/provider.dart';
import '../../provider.dart';

class SettingsScreenWidget extends StatefulWidget {
  final User? user;

  const SettingsScreenWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidget();
}

class _SettingsScreenWidget extends State<SettingsScreenWidget> {
  List<String> dropdownItems = ['English', 'Lithuanian', 'Russian'];
  String selectedValue = 'English';
  User? user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = widget.user;
    });
  }

  Locale getLocaleForLanguage(String language) {
    switch (language) {
      case 'English':
        return const Locale('en');
      case 'Lithuanian':
        return const Locale('lt');
      case 'Russian':
        return const Locale('ru');
      default:
        return const Locale('en');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(user?.username ?? 'default Username',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const Text("Premium",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
            Text(user?.email ?? 'default email',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15)),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 200,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Card(
                    child: ListTile(
                      title: Text("More Stats"),
                      subtitle: Text("Work in progress"),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity, // Set width to take full width
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align children to the start (left) in a column
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 10, bottom: 5),
                      child: Text(S.of(context).PaymentPlan,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 8.0, bottom: 5),
                      child: Text(S.of(context).Status,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 8.0, bottom: 5),
                      child: Text(S.of(context).ExpiryDate,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 10),
                      child: Text(S.of(context).UpdatePlan,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(S.of(context).DarkMoid),
                    subtitle: Text(S.of(context).EnableDarkMode),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Switch(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(S.of(context).Language),
                    subtitle: Text(S.of(context).SelectLanguage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedValue = newValue;
                        });
                        Locale newLocale = getLocaleForLanguage(newValue);
                        Provider.of<LocaleProvider>(context, listen: false)
                            .setLocale(newLocale);
                      }
                    },
                    items: dropdownItems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
