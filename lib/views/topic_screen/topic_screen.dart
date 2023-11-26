import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import '../../services/api/question_service.dart';
import '/models/topic.dart';
import '/models/question.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api/question_service.dart';

class TopicScreenWidget extends StatefulWidget {
  final Topic topic;

  const TopicScreenWidget({Key? key, required this.topic}) : super(key: key);

  @override
  State<TopicScreenWidget> createState() => _TopicScreenWidget();
}

class _TopicScreenWidget extends State<TopicScreenWidget> {
  List<Question> questions = [];
  late Topic topic;

  @override
  void initState() {
    super.initState();
    topic = widget.topic;
    _getQuestionsForTopic();
  }

  Future<void> _getQuestionsForTopic() async {
    var loadedQuestions = await getExam();

    var multipliedQuestions = <Question>[];
    for (var question in loadedQuestions) {
      for (int i = 0; i < 20; i++) {
        multipliedQuestions.add(question);
      }
    }

    setState(() {
      questions = multipliedQuestions;
    });
  }

  List<PieChartSectionData> _getSections() {
    double passedPercentage = 65; //
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

  Color? _getCellColor(int index) {}

  TextStyle _getTextStyle(int index) {
    // if (!answeredQuestions.containsKey(index)) {
    //   return TextStyle(color: Colors.black);
    // }
    // return TextStyle(color: Colors.white);
    return TextStyle(color: Colors.black);
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
            topic.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      Theme.of(context).colorScheme.primary, // Set border color
                  width: 2.0, // Set border width
                ),
              ),
              child: SingleChildScrollView(
                // Wrap with SingleChildScrollView
                child: GridView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Disable GridView's own scroll
                  itemCount: questions.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // Adjusted for visibility
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => "",
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: _getCellColor(
                              index), // Change color based on answer status
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: _getTextStyle(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Text(topic.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    color: Colors.black)),
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
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
                      width: 20), // Spacing between the legend and the chart
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
            margin: const EdgeInsets.only(top: 40),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: const Size(325, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Start",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
