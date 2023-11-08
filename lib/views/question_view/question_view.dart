import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class QuestionViewWidget extends StatefulWidget {
  const QuestionViewWidget({super.key});

  @override
  State<QuestionViewWidget> createState() => _QuestionViewWidget();
}

class _QuestionViewWidget extends State<QuestionViewWidget> {
  List<String> descriptions = [
    " Красный легковой автомобиль, затем синий легковой автомобиль одновременно с белым.",
    " Красный легковой автомобиль, затем синий легковой автомобиль одновременно с белым.",
    " Красный легковой автомобиль, затем синий легковой автомобиль одновременно с белым.",
    " Красный легковой автомобиль, затем синий легковой автомобиль одновременно с белым."
  ];

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
            Text('Exam'), // First text element
            Text('10:50'),
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
                            itemCount: 30,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6, // Adjusted for visibility
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Handle cell tap
                                  Navigator.pop(
                                      context); // Close the modal when an item is tapped
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: Text('${index + 1}'),
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
              alignment: Alignment.center,
              child: Image.network(
                'https://auto-test.online/static/custom/img/md/B/229.jpg#1698921619',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Каким из указанных опознавательных знаков обозначаются транспортные средства, перевозящие груз, который выступает за габариты транспортного средства по длине сзади более чем на 1 м, по ширине - более чем на 0,4 м от внешнего края габаритного огня?',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            child: Column(
              children: List.generate(descriptions.length, (index) {
                String letter = 'ABCD'[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      minimumSize: Size(double.infinity,
                          MediaQuery.of(context).size.height * 0.09),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "$letter: ${descriptions[index]}",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin:
            EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back arrow tap
              },
            ),
            IconButton(
              icon: Icon(Icons.error_outline),
              onPressed: () {
                // Handle back arrow tap
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                // Handle forward arrow tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
