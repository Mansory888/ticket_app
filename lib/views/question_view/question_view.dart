import 'package:flutter/material.dart';
import 'package:ticket_app/models/question.dart';
import '../../generated/l10n.dart';
import '../../models/answer.dart';
import 'dart:convert';
import 'package:ticket_app/views/finish_screen/finish_screen.dart';
import '../../services/api/question_service.dart';

class QuestionViewWidget extends StatefulWidget {
  final List<Question> questions;
  final bool isExam;

  const QuestionViewWidget(
      {Key? key, required this.questions, required this.isExam})
      : super(key: key);

  @override
  State<QuestionViewWidget> createState() => _QuestionViewWidget();
}

class _QuestionViewWidget extends State<QuestionViewWidget> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  Map<int, bool?> answeredQuestions = {};
  Map<int, int?> selectedAnswers = {};
  bool isExam = false;

  @override
  void initState() {
    super.initState();
    // Now, questions are already provided by the parent widget
    // So, you can directly use them instead of loading from 'loadExam'
    setState(() {
      questions = widget.questions;
      isExam = widget.isExam;
    });
  }

  void goToQuestion(int index, bool table) {
    setState(() {
      currentQuestionIndex = index;
      // Mark as viewed if not answered yet
      answeredQuestions.putIfAbsent(index, () => null);
    });
    if (table) {
      Navigator.pop(context);
    }
  }

  // Call this method when an answer is selected
  void answerQuestion(int questionIndex, int asnwerIndex, bool isCorrect) {
    setState(() {
      answeredQuestions[questionIndex] = isCorrect;
      selectedAnswers[questionIndex] = asnwerIndex;
    });

    if (answeredQuestions.length == questions.length) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishScreenWidget(
            questions: questions,
            answeredQuestions: answeredQuestions,
          ),
        ),
      );
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      goToQuestion(currentQuestionIndex - 1, false);
    }
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      goToQuestion(currentQuestionIndex + 1, false);
    }
  }

  // Widget to display the current question image
  Widget _buildQuestionImage() {
    if (questions.isNotEmpty) {
      return Image.network(
        questions[currentQuestionIndex].image,
        fit: BoxFit.contain,
      );
    } else {
      return SizedBox(); // Return an empty box if there are no questions
    }
  }

  Color? _getCellColor(int index) {
    if (!answeredQuestions.containsKey(index)) {
      return null; // default color
    }

    if (answeredQuestions[index] == null) {
      return Colors.blue; // viewed but not answered
    }

    if (isExam) {
      return Colors.blue;
    }
    return answeredQuestions[index]! ? Colors.green : Colors.red; // answered
  }

  TextStyle _getTextStyle(int index) {
    if (!answeredQuestions.containsKey(index)) {
      return TextStyle(color: Colors.black);
    }
    return TextStyle(color: Colors.white);
  }

  // Widget to display the current question text
  Widget _buildQuestionText() {
    if (questions.isNotEmpty) {
      return Text(
        questions[currentQuestionIndex].question,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
      );
    } else {
      return SizedBox(); // Return an empty box if there are no questions
    }
  }

  // Widget to build answer buttons for the current question
  List<Widget> _buildAnswerButtons() {
    if (questions.isNotEmpty) {
      bool isQuestionAnswered = answeredQuestions[currentQuestionIndex] != null;

      return questions[currentQuestionIndex]
          .answers
          .asMap()
          .entries
          .map((entry) {
        int idx = entry.key;
        Answer answer = entry.value;
        String letter = 'ABCD'[idx % 4];
        // Determine button color based on whether the answer is correct or incorrect
        Color buttonColor;

        if (selectedAnswers[currentQuestionIndex] == idx) {
          if (isExam) {
            buttonColor = Colors.white; // If it's not an exam, always white
          } else {
            if (answeredQuestions[currentQuestionIndex] == true) {
              buttonColor = Colors.green; // Correct answer in exam
            } else {
              buttonColor = Colors.red; // Incorrect answer in exam
            }
          }
        } else {
          buttonColor = Colors.white; // Not selected
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ElevatedButton(
            onPressed: () {
              if (!isQuestionAnswered) {
                answerQuestion(currentQuestionIndex, idx, answer.isCorrect);
                goToNextQuestion();
              }
            }, // Disable button if the question has been answered
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: Size(
                  double.infinity, MediaQuery.of(context).size.height * 0.09),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("$letter: ${answer.answer}",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: (!isExam ||
                          (isQuestionAnswered &&
                              selectedAnswers[currentQuestionIndex] == idx))
                      ? Colors.black
                      : Theme.of(context).colorScheme.tertiary,
                )),
          ),
        );
      }).toList();
    } else {
      return []; // Return an empty list if there are no questions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).Exam), // First text element
            Text('10:50'),
            Container(
                margin: const EdgeInsets.fromLTRB(
                    16.0, 4, 16.0, 0), // Add horizontal padding
                child: IconButton(
                  icon: const Icon(Icons.table_chart),
                  onPressed: () {
                    print(answeredQuestions);
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height *
                              0.5, // Half the screen height
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: questions.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6, // Adjusted for visibility
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => goToQuestion(index, true),
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
                                      style: _getTextStyle(
                                          index), // Change text style based on answer status
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                )), // Second text element
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width:
                double.infinity, // This will take the full width of the screen
            height: MediaQuery.of(context).size.height *
                0.25, // Set your desired height for the image container
            child: Align(
                alignment: Alignment.center, child: _buildQuestionImage()),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildQuestionText(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            child: Column(children: _buildAnswerButtons()),
          ),
        ],
      ),
      bottomSheet: Container(
        margin:
            EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Visibility(
              visible: currentQuestionIndex > 0,
              replacement: const SizedBox(width: 48),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed:
                    currentQuestionIndex > 0 ? goToPreviousQuestion : null,
              ),
            ),
            IconButton(
              icon: Icon(Icons.error_outline),
              onPressed: () {
                // Handle back arrow tap
              },
            ),
            Visibility(
              visible: currentQuestionIndex < questions.length - 1,
              replacement: const SizedBox(width: 48),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: currentQuestionIndex < questions.length - 1
                    ? goToNextQuestion
                    : null,
              ),
              // Keep space for alignment
            ),
          ],
        ),
      ),
    );
  }
}
