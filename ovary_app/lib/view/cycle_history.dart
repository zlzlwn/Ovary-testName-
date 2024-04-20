import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/home.dart';

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
  double cycleLengthAverage = 0.0;


  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' 올해 나의 생리주기'),
        backgroundColor: Colors.pink[100],
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
                swapAnimationDuration: const Duration(milliseconds: 250),
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
                    backgroundColor: Colors.pink[300],
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
      return _makeGroupData(i, cycleLengths[i], barColor: Colors.pink);
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
            toY: 30,
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

findCycleAverage() {
    // Calculate the sum of all cycle lengths
    double sum = cycleLengths.reduce((value, element) => value + element);

    // Calculate the average cycle length
    cycleLengthAverage = sum / 12;

    print(cycleLengthAverage);
    // Call setState to update the UI and show the calculated average
    setState(() {});
}


// Fetch data from Firebase
  Future<void> fetchDataFromFirebase() async {
    // Get email from GetStorage
    final box = GetStorage();
    String? email = box.read<String>('email');
    
    if (email == null) {
      print('Email not found in GetStorage box');
      return;
    }

    try {
      // Query Firestore to find the document with the specified email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      // Check if a document is found
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

        // Get the 'period' map from data
        Map<String, dynamic>? periodMap = data?['period'] as Map<String, dynamic>?;

        if (periodMap != null) {
          // Process the periodMap to extract cycle lengths and their corresponding months
          processPeriodData(periodMap);
        }
      } else {
        print('No document found with the specified email.');
      }
    } catch (error) {
      print('Failed to fetch data from Firebase: $error');
    }
  }


  // Process the period map data
processPeriodData(Map<String, dynamic> periodMap) {
    // Reset cycle lengths
    cycleLengths = List.filled(12, 0); // Reset cycle lengths to zeros

    // Iterate through periodMap and populate cycleLengths based on the month
    periodMap.forEach((timestamp, periodInfo) {
        // periodInfo contains an array with the date, period length, and cycle length
        List<dynamic> periodData = periodInfo;

        // Extract the date from periodInfo
        String date = periodData[0];
        DateTime periodDate = DateTime.parse(date);

        // Extract the cycle length
        double cycleLength = periodData[2].toDouble();

        // Get the month (1-12) from periodDate
        int month = periodDate.month - 1;

        // Store the cycle length in the corresponding month index
        cycleLengths[month] = cycleLength;
    });

    // Now that cycleLengths has been populated, calculate the average
    findCycleAverage();
}



} //END
