import 'package:flutter/material.dart';
import '../../services/api/user_service.dart';
import '../../generated/l10n.dart';

class SpashScreenWidget extends StatelessWidget {
  const SpashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        shadowColor: Colors.transparent,
        toolbarHeight: 1,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Icon(Icons.directions_car, size: 40),
            ),
          ),

          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Image.network(
                'https://media.istockphoto.com/id/1186972461/photo/generic-white-car-isolated-on-white-background.jpg?s=170667a&w=0&k=20&c=YBXP60_tIGgrs4LRT6oS64PYFlqBhN1Pqeh6heV9UFs=',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              S.of(context).startTheJourney,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.06,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Smaller text below
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              S.of(context).passingExamMessage,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 0),
            child: ElevatedButton(
              onPressed: () async {
                bool isLoggedIn = await checkUserData();

                if (isLoggedIn) {
                  Navigator.pushReplacementNamed(context, '/main');
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize:
                    Size(325, MediaQuery.of(context).size.height * 0.10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                S.of(context).letsGetStarted,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
