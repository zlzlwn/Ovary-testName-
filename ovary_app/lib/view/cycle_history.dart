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
class _periodCycleChartState extends State<periodCycleChart> {
  // Store the list of cycle lengths for each month
  List<double> cycleLengths = List.filled(12, 0); // Initialize with zeros
  List<int> daysBetweenPeriods = List.filled(11, 0); // List to store days between periods
  double cycleLengthAverage = 0.0;


  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
    fetchCycleLengthsFromFirebase();
    
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
              child: BarChart(
                _mainBarData(),
                swapAnimationDuration: const Duration(milliseconds: 1000),
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
              onPressed: () => Get.to(const Home()),
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

  BarChartData _mainBarData() {
  return BarChartData(
    barTouchData: BarTouchData(
      enabled: true,
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTitlesWidget: _getMonthTitles,
        ),
        // Add x-axis title here
        axisNameSize: 45, // Space for the axis title
        axisNameWidget: const Text(
          '월 (Months)', // x-axis title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 5,
          // getTitles: _getDayTitles,
        ),
        // Add y-axis title here
        axisNameSize: 19, // Space for the axis title
        axisNameWidget: Text(
          '일 (Days)', // y-axis title
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
    barGroups: _showingGroups(),
    gridData: const FlGridData(show: false),
  );
}



  // Generate the bar chart data based on cycleLengths
List<BarChartGroupData> _showingGroups() {
  return List.generate(12, (i) {
    return _makeGroupData(i, cycleLengths[i], barColor: Color(0xff8b7ff5));
  });
}

  // Function to create bar chart group data
  BarChartGroupData _makeGroupData(
    int x,
    double y, {
    Color? barColor,
    double width = 15,
  }) {
    barColor ??= Colors.white;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: barColor,
          width: width,
          borderSide: BorderSide.none,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 40,
            color: Colors.white,
          ),
        ),
      ],
    );
  }




  // Function to generate bottom (month) titles
  Widget _getMonthTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    List<String> months = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
    String month = months[value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(month, style: style),
    );
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
  List<int> daysBetweenPeriods = [];

  // Create a list of DateTime objects from periodMap and sort them chronologically
  List<DateTime> periodDates = periodMap.values.map((periodInfo) {
    List<dynamic> periodData = periodInfo;
    String date = periodData[0];
    return DateTime.parse(date);
  }).toList();

periodDates.sort((a, b) => a.month.compareTo(b.month));

print("Sorted periodDates: $periodDates");

  // Calculate days between consecutive periods
  for (int i = 0; i < periodDates.length - 1; i++) {
    int daysDifference = periodDates[i + 1].difference(periodDates[i]).inDays;
    daysBetweenPeriods.add(daysDifference);
  }

print("Days between periods: $daysBetweenPeriods");

  // Calculate period cycle average
  double cycleLengthAverage = 0.0;
  if (daysBetweenPeriods.isNotEmpty) {
    // Consider three most recent intervals
    List<int> recentIntervals = daysBetweenPeriods.sublist(0, 3);
    // Calculate sum of recent intervals
    int sum = recentIntervals.reduce((value, element) => value + element);
    // Calculate average
    cycleLengthAverage = sum / recentIntervals.length;
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
