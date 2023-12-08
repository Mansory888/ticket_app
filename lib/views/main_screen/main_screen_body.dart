import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api/question_service.dart';
import '../question_view/question_view.dart';
import '../topic_screen/topic_list_screen.dart';
import 'package:ticket_app/views/settings_screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:ticket_app/models/user.dart';

class MainScreenBodyWidget extends StatefulWidget {
  final User? user;

  const MainScreenBodyWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreenBodyWidget> createState() => _MainScreenBodyWidget();
}

class _MainScreenBodyWidget extends State<MainScreenBodyWidget> {
  User? user;

  @override
  void initState() {
    super.initState();
    setState(() {
      user = widget.user;
    });
  }

  void loadExam() async {
    try {
      var mockExam = await getExam(user!.userId ?? 0, user!.languageId ?? 1);

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

  List<PieChartSectionData> _getSections() {
    double passedPercentage = 65; // Example value, replace with your data
    double notPassedPercentage = 100 - passedPercentage;

    return [
      PieChartSectionData(
        color: Colors.green,
        value: passedPercentage,
        title: "$passedPercentage %",
        radius: 40,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: notPassedPercentage,
        title: "$notPassedPercentage %",
        radius: 40,
      ),
    ];
  }

  TableRow _buildTableRow(String leftText, String rightText) {
    return TableRow(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftText),
              Text(rightText),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRowWithColor(
      String leftText, String rightText, Color color) {
    return TableRow(
      children: [
        Container(
          color: color,
          padding: EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftText, style: TextStyle(color: Colors.white)),
              Text(rightText, style: TextStyle(color: Colors.white)),
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
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Legend
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.green,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                              ),
                              Text(S.of(context).passed),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                color: Colors.red,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 4.0),
                              ),
                              Text(S.of(context).notPassed),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                          width:
                              20), // Spacing between the legend and the chart
                      // Pie chart
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: PieChart(
                          PieChartData(
                            sections: _getSections(),
                            sectionsSpace: 0,
                            centerSpaceRadius: 20,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      children: [
                        _buildTableRow('Player 1', '1000pts'),
                        _buildTableRow('Player 2', '800pts'),
                        _buildTableRow('Player 3', '600pts'),
                        _buildTableRowWithColor('Player 4', '400pts',
                            Theme.of(context).colorScheme.primary),
                      ],
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
