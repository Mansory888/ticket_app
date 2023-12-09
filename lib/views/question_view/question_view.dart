import 'package:flutter/material.dart';
import 'package:ticket_app/models/mock_exam.dart';
import 'package:ticket_app/models/question.dart';
import 'package:ticket_app/models/question_list.dart';
import '../../generated/l10n.dart';
import '../../models/answer.dart';
import 'dart:convert';
import 'package:ticket_app/views/finish_screen/finish_screen.dart';
import '../../services/api/question_service.dart';
import 'dart:async';
import 'package:ticket_app/models/user.dart';
import '../../services/api/user_service.dart';

class QuestionViewWidget extends StatefulWidget {
  final List<Question> questions;
  final MockExam? mockExam;
  final bool isExam;

  const QuestionViewWidget(
      {Key? key, required this.questions, required this.isExam, this.mockExam})
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
  MockExam? mockExam;
  Timer? _timer;
  int _remainingTime = 30 * 60;

  @override
  void initState() {
    super.initState();

    setState(() {
      questions = [...widget.questions];
      isExam = widget.isExam;
      mockExam = widget.mockExam;
    });

    if (isExam) {
      startTimer();
      mockExam!.answered_questions =
          QuestionList(questions: [], totalQuestions: questions.length);
    }
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

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_remainingTime <= 0) {
        finishExam();
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }

  // Call this method when an answer is selected
  void answerQuestion(int questionIndex, int asnwerIndex, bool isCorrect) {
    setState(() {
      answeredQuestions[questionIndex] = isCorrect;
      selectedAnswers[questionIndex] = asnwerIndex;
    });

    if (answeredQuestions.length == questions.length) {
      finishExam();
    }

    if (isExam) {
      Question question = questions[questionIndex];
      Answer answer = question.answers[asnwerIndex];

      question.answers.clear();
      question.answers.add(answer);
      mockExam!.answered_questions!.questions.add(question);
    }

    if (!isExam) {
      _chckQuestion(questions[questionIndex]);
    }
  }

  Future<void> _chckQuestion(Question question) async {
    User userData = await getUserData();
    await postQuestion(question, userData.userId!);
  }

  void finishExam() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FinishScreenWidget(
          questions: questions,
          answeredQuestions: answeredQuestions,
          isExam: isExam,
          mockExam: mockExam,
        ),
      ),
    );
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
      return const SizedBox(); // Return an empty box if there are no questions
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
      return const TextStyle(color: Colors.black);
    }
    return const TextStyle(color: Colors.white);
  }

  // Widget to display the current question text
  Widget _buildQuestionText() {
    if (questions.isNotEmpty) {
      return Text(
        questions[currentQuestionIndex].question,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
      );
    } else {
      return const SizedBox(); // Return an empty box if there are no questions
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
    int minutes = _remainingTime ~/ 60;
    int seconds = _remainingTime % 60;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isExam
                ? Text(S.of(context).Exam)
                : Text(S.of(context).Topic), // First text element
            Text('$minutes:${seconds.toString().padLeft(2, '0')}'),
            Container(
                margin: const EdgeInsets.fromLTRB(
                    16.0, 4, 16.0, 0), // Add horizontal padding
                child: IconButton(
                  icon: const Icon(Icons.table_chart),
                  onPressed: () {
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
              icon: const Icon(Icons.error_outline),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ListTile(
                                title: Text(
                                  S.of(context).ReportQuestion,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(S.of(context).QuestionWrong),
                              ),
                              const SizedBox(
                                height: 200,
                                child: TextField(
                                  maxLines: null, // Set this
                                  expands: true,
                                  maxLength: 200, // and this
                                  keyboardType: TextInputType
                                      .multiline, // Allows for multiple lines
                                  textAlignVertical: TextAlignVertical
                                      .top, // Aligns text to the top
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        minimumSize:
                                            const Size(double.infinity, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(S.of(context).Cancel),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        minimumSize:
                                            const Size(double.infinity, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(S.of(context).Send),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ));
                    });
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
