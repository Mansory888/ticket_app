import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../services/api/question_service.dart';
import 'topic_screen.dart';
import '/models/topic.dart';
import 'package:ticket_app/models/user.dart';
import '../../services/api/user_service.dart';

class TopicListScreenWidget extends StatefulWidget {
  const TopicListScreenWidget({super.key});

  @override
  State<TopicListScreenWidget> createState() => _TopicListScreenWidget();
}

class _TopicListScreenWidget extends State<TopicListScreenWidget> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    _getTopics();
  }

  Future<void> _getTopics() async {
    User userData = await getUserData();
    final List<Topic> topics = await getAllTopics(userData.languageId ?? 1);
    setState(() {
      this.topics = topics;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          toolbarHeight: 40.0,
          title: Text(
            S.of(context).Topics,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TopicScreenWidget(topic: topics[index]),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  topics[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(topics[index].description)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
