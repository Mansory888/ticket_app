import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/answer.dart';
import 'package:ticket_app/models/topic.dart';
import '../../services/api/question_service.dart';
import '../question_view/question_view.dart';
import 'package:ticket_app/views/main_screen/main_screen.dart';

class FinishScreenWidget extends StatefulWidget {
  final List<Question> questions;
  final Map<int, bool?> answeredQuestions;

  const FinishScreenWidget(
      {Key? key, required this.questions, required this.answeredQuestions})
      : super(key: key);

  @override
  State<FinishScreenWidget> createState() => _FinishScreenWidget();
}

class _FinishScreenWidget extends State<FinishScreenWidget> {
  int passedQ = 0;
  int lengthQ = 0;
  int percentage = 0;
  List<Question> questions = [];
  Map<int, bool?> answeredQuestions = {};

  @override
  void initState() {
    super.initState();

    setState(() {
      questions = widget.questions;
      answeredQuestions = widget.answeredQuestions;
      passedQ = widget.answeredQuestions.values
          .where((element) => element == true)
          .length;
      lengthQ = widget.questions.length;
      percentage = (passedQ / lengthQ * 100).round();
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
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          Text(
            S.of(context).ExamComplete, // Example of a localized string
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.060,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).Youhaveanswered +
                      " $passedQ / $lengthQ " +
                      S
                          .of(context)
                          .questionscorrectly, // Example of a localized string
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  S.of(context).Thatis +
                      " $percentage %", // Example of a localized string
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreenWidget()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(S.of(context).backtomenu),
              ),
              ElevatedButton(
                onPressed: () async {
                  // var loadedQuestions = await getExam();

                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => QuestionViewWidget(
                  //       questions: loadedQuestions,
                  //       isExam: true,
                  //     ),
                  //   ),
                  // );
                },
                child: Text(S.of(context).retry),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                S
                    .of(context)
                    .Questionsyoufailed, // Example of a localized string
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.060,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                    top: 2.0,
                  ),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align children to the start of the column
                      children: <Widget>[
                        ListTile(
                          title: Text(questions[index].question),
                          subtitle: Text(questions[index]
                              .answers
                              .where((element) => element.isCorrect == true)
                              .first
                              .answer),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            questions[index]
                                .explanation, // Replace with your text
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          ),
                        ),
                        // You can add more widgets here if needed
                      ],
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
