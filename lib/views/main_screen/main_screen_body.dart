import 'package:flutter/material.dart';
import 'package:ticket_app/models/mock_exam.dart';
import 'package:ticket_app/models/user_response.dart';
import '../../generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api/question_service.dart';
import '../question_view/question_view.dart';
import '../topic_screen/topic_list_screen.dart';
import 'package:ticket_app/views/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user.dart';
import '../../services/api/user_service.dart';

class MainScreenBodyWidget extends StatefulWidget {
  final UserResponse? user;

  const MainScreenBodyWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreenBodyWidget> createState() => _MainScreenBodyWidget();
}

class _MainScreenBodyWidget extends State<MainScreenBodyWidget> {
  UserResponse? user;
  List<UserResponse> top4Users = [];
  MockExam? lastMockExam;

  @override
  void initState() {
    super.initState();
    loadUsers();
    loadLastMockExam();
    setState(() {
      user = widget.user;
    });
  }

  void loadExam() async {
    try {
      var mockExam = await getExam(user!.language_id ?? 1);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionViewWidget(
            questions: mockExam.questions!.questions,
            isExam: true,
            mockExam: mockExam,
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void loadUsers() async {
    try {
      var users = await getAllUsers();

      users.sort((a, b) => b.score?.compareTo(a.score ?? 0) ?? 0);

      var top4Users = users.take(4).toList();

      setState(() {
        this.top4Users = top4Users;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void loadLastMockExam() async {
    try {
      List<MockExam> mockExams = await getAllMockExams();
      mockExams.sort((a, b) {
        return b.completion_date!.compareTo(a.completion_date!);
      });

      setState(() {
        lastMockExam = mockExams.isNotEmpty ? mockExams.first : null;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  TableRow _buildTableRow(String leftText, String rightText, {Color? color}) {
    Color textColor = color != null ? Colors.white : Colors.black;

    return TableRow(
      decoration: BoxDecoration(
        color: color, // Apply the background color if provided
      ),
      children: [
        Container(
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftText,
                style: TextStyle(color: textColor),
              ),
              Text(
                rightText,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  S.of(context).Welcome,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.all(10), // Adjust the padding as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      lastMockExam?.percentage != null &&
                              lastMockExam!.percentage >= 80
                          ? S.of(context).lastExamPassed
                          : S.of(context).lastExamFailed,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lastMockExam?.percentage != null &&
                                lastMockExam!.percentage >= 80
                            ? Colors.green
                            : Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          "${lastMockExam?.percentage ?? 0}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).leaderBoard,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    Table(
                      border: TableBorder.all(), // Add borders to the table
                      children: top4Users.map((user) {
                        return _buildTableRow(
                          user.username,
                          '${user.score} pts',
                          color: user.user_id == this.user?.user_id
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).Start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/topicList');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              S.of(context).Topics,
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              loadExam();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              minimumSize: const Size(double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              S.of(context).Exam,
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
      ),
    );
  }
}
