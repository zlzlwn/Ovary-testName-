import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/home.dart';
import 'package:ovary_app/view/period_Input.dart';

// ignore: camel_case_types
class periodCycleChart extends StatefulWidget {
  const periodCycleChart({super.key});

  @override
  State<periodCycleChart> createState() => _periodCycleChartState();
}

// ignore: camel_case_types
class _periodCycleChartState extends State<periodCycleChart>with TickerProviderStateMixin {
  // Store the list of cycle lengths for each month
  List<double> cycleLengths = List.filled(12, 0); // Initialize with zeros
  List<int> daysBetweenPeriods = List.filled(11, 0); // List to store days between periods
  double cycleLengthAverage = 0.0;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
    fetchCycleLengthsFromFirebase();
    _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    )..addListener(() {
    setState(() {});
  });
  _animationController.forward();
  }

@override
  void dispose() {
    _animationController.dispose();
    super.dispose();

  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(' 올해 나의 생리주기'),
    ),
    body: Column(
      children: [
        const SizedBox(height: 150),
        AspectRatio(
          aspectRatio: 1.1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(9, 0, 15, 0),
            child: LineChart(
              _mainLineData(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '평균 생리주기:   ${cycleLengthAverage.toStringAsFixed(0)} 일',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(height: 100),
        ElevatedButton(
          onPressed: () => {Get.back(), Get.back()},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(120, 50),
            backgroundColor: Color(0xff8b7ff5),
          ), 
          child: Text(
            '홈으로',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _getMonthTitles(double value, TitleMeta meta, List<double> cycleLengths) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  List<String> months = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
  String month = months[value.toInt()];
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: Text(month, style: style),
  );
}

LineChartData _mainLineData() {
  return LineChartData(
    lineTouchData: const LineTouchData(
      enabled: true,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTitlesWidget: (double value, TitleMeta meta) => _getMonthTitles(value, meta, cycleLengths), // Pass cycleLengths
        ),
        axisNameSize: 45,
        axisNameWidget: const Text(
          'Month(월)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (double value, TitleMeta meta) => _getDayTitles(value, meta), // No need to pass cycleLengths
          interval: 5,
        ),
        axisNameSize: 19,
        axisNameWidget: const Text(
          'Days(일)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(show: false),
    lineBarsData: _showingLines(),
    gridData: const FlGridData(show: false),
    minY: 0,
    maxY: 40,
  );
}

Widget _getDayTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: Text(value.toInt().toString(), style: style),
  );
}


List<LineChartBarData> _showingLines() {
  final animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  List<FlSpot> spots = [];
  for (int i = 0; i < cycleLengths.length; i++) {
    spots.add(FlSpot(i.toDouble(), cycleLengths[i] * animation.value));
  }
  return [
    LineChartBarData(
      spots: spots,
      isCurved: true,
      color: const Color(0xff8b7ff5),
      barWidth: 2.5,
      belowBarData: BarAreaData(
        show: true,
        color: const Color(0xff8b7ff5).withOpacity(0.3),
      ),
    ),
  ];
}

//FUNCTIONS 

  Future<void> fetchDataFromFirebase() async {
    final box = GetStorage();
    String? email = box.read<String>('email');

    if (email == null) {
      print('Email not found in GetStorage box');
      return;
    }

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        Map<String, dynamic>? periodMap = data?['period'] as Map<String, dynamic>?;

        if (periodMap != null) {
          processPeriodData(periodMap);
        } else {
          _showNoDataDialog();
          print('No period data found in the specified document.');
        }
      } else {
        _showNoDataDialog();
        print('No document found with the specified email.');
      }
    } catch (error) {
      print('Failed to fetch data from Firebase: $error');
    }
  }


_showNoDataDialog() {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("데이터가 없습니다."),
        actions: [
          CupertinoDialogAction(
            child: const Text("확인"),
            onPressed: () {
              // Dismiss the dialog
              Navigator.of(context).pop();
              // Go back to the previous screen
              Get.to(const PeriodInput());
            },
          ),
        ],
      );
    },
  );
}






// PROCESS PERIOD DATA FROM FIREBASE STORAGE TO FIND THE AVG CYCLE LENGTH
processPeriodData(Map<String, dynamic> periodMap) {
  // Initialize a map to store the most recent period date for each month
  Map<int, DateTime> recentPeriodDates = {};

  // Iterate through period data to find the most recent date for each month
  periodMap.forEach((key, value) {
    List<dynamic> periodData = value;
    String date = periodData[0];
    DateTime periodDate = DateTime.parse(date);
    int month = periodDate.month;
    // Update recentPeriodDates with the most recent date for each month
    if (recentPeriodDates.containsKey(month)) {
      DateTime existingDate = recentPeriodDates[month]!;
      // Check if the current date is more recent
      if (periodDate.isAfter(existingDate)) {
        recentPeriodDates[month] = periodDate;
      }
    } else {
      recentPeriodDates[month] = periodDate;
    }
  });

  print("Recent period dates: $recentPeriodDates");

  // Calculate days between consecutive periods for recent dates of each month
  List<int> daysBetweenPeriods = recentPeriodDates.values.map((date) {
    return date.day - 1; // Subtract 1 to get the day count
  }).toList();

  print("Days between recent periods: $daysBetweenPeriods");

  // Calculate period cycle average
  double cycleLengthAverage = 0.0;
  if (daysBetweenPeriods.isNotEmpty) {
    // Calculate sum of all intervals
    int sum = daysBetweenPeriods.reduce((value, element) => value + element);
    // Calculate average
    cycleLengthAverage = sum / daysBetweenPeriods.length;
  }

  print("Cycle length average: $cycleLengthAverage");

  setState(() {
    this.cycleLengthAverage = cycleLengthAverage;
  });
}










Future<void> fetchCycleLengthsFromFirebase() async {
  final box = GetStorage();
  String? email = box.read<String>('email');

  if (email == null) {
    print('Email not found in GetStorage box');
    return;
  }

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

      Map<String, dynamic>? periodMap = data?['period'] as Map<String, dynamic>?;

      if (periodMap != null) {
        processCycleLengthData(periodMap);
      } else {
        _showNoDataDialog();
        print('No period data found in the specified document.');
      }
    } else {
      _showNoDataDialog();
      print('No document found with the specified email.');
    }
  } catch (error) {
    print('Failed to fetch data from Firebase: $error');
  }
}

// Process cycle length data from Firebase storage
processCycleLengthData(Map<String, dynamic> periodMap) {
  // Initialize cycle lengths list
  List<double> cycleLengths = List.filled(12, 0);

  // Iterate through period data to find the latest cycle length for each month
  periodMap.forEach((key, value) {
    List<dynamic> periodData = value;
    String date = periodData[0];
    int month = DateTime.parse(date).month;
    double cycleLength = periodData[2].toDouble();
    // Update cycle length if it's greater than the existing one for the month
    if (cycleLength > cycleLengths[month - 1]) {
      cycleLengths[month - 1] = cycleLength;
    }
  });

  // Update state with retrieved cycle lengths
  setState(() {
    this.cycleLengths = cycleLengths;
  });
}









} //END
