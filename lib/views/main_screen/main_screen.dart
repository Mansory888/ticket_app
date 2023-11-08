import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:fl_chart/fl_chart.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidget();
}

class _MainScreenWidget extends State<MainScreenWidget> {
  int _selectedIndex = 0; // This will track the selected index

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Settings Page'),
  ];

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        shadowColor: Colors.transparent,
        toolbarHeight: 10.0,
      ),
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
                              // Handle button press here
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
                              S.of(context).Questions,
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
                              // Handle button press here
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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.of(context).Home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: S.of(context).Settings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
