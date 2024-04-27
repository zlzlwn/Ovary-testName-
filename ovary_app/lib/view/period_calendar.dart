import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:ovary_app/view/cycle_history.dart';
import 'package:ovary_app/view/home.dart';
import 'package:ovary_app/view/period_Input.dart';
import 'package:table_calendar/table_calendar.dart';


class PeriodCalender extends StatefulWidget {
  const PeriodCalender({super.key});
  @override
  State<PeriodCalender> createState() => _PeriodCalenderState();
}


class _PeriodCalenderState extends State<PeriodCalender> {
    // Properties
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _focusedDay = DateTime.now();
    DateTime? _rangeStart;
    DateTime? _rangeEnd;
    int periodLength = 7; // Default period length
    int cycleLength = 28; // Default cycle length 
    DateTime? nextPeriodDay; // predicted period start day 

     // Temporary values for month navigation
  DateTime? _tempRangeStart;
  DateTime? _tempRangeEnd;


String formatNextPeriodDay(DateTime? nextPeriodDay) {
  if (nextPeriodDay != null) {
    return DateFormat('yyyy-MM-dd').format(nextPeriodDay);
  } else {
    return '';
  }
}

String formatFocusedDay (DateTime? _focusedDay){
  if(_focusedDay != null){
    return DateFormat('yyyy-MM-dd').format(_focusedDay);
  }else{
    return '';
  }
}


@override
void initState() {
    super.initState();
    retrievePeriodData();
}


@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('나의 생리주기 캘린더'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const PeriodInput());
                },
              icon: const Icon(Icons.edit)
            )
          ],
        ),
      body: Column(
        children: [
        const SizedBox(height: 50),
        TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.sunday,
         rangeStartDay: _tempRangeStart ?? _rangeStart, // Use _rangeStart if _tempRangeStart is null
            rangeEndDay: _tempRangeEnd ?? _rangeEnd, // Use _rangeEnd if _tempRangeEnd is null
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            rangeStartDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff8b7ff5).withOpacity(1),
            ),
            rangeHighlightColor: Color(0xff8b7ff5).withOpacity(0),
            rangeEndDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff8b7ff5).withOpacity(1),
            ),
            withinRangeDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color:const Color(0xff8b7ff5).withOpacity(0.2),
            ),
            todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:  Color.fromARGB(255, 245, 190, 106),
            ),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                  _calendarFormat = format;
                  setState(() {});
              }
            },
            onPageChanged:(focusedDay) {
                _onPageChanged(focusedDay);
            },
          ),
          const SizedBox(height: 20),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              // Legend for the start and end of the period
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                color: const Color(0xff8b7ff5).withOpacity(1),
                shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('생리 시작/끝 날짜', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 20),
              // Legend for today's date
              Container(
                  width: 20,
                  height: 20,
                  decoration: const  BoxDecoration(
                  color: Color.fromARGB(255, 245, 190, 106),
                  shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 8),
              const Text('오늘날짜', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset('images/periodStart.png',width: 40),
                    Padding(
                    padding:  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text('생리 시작날짜 :  ${formatFocusedDay(_rangeStart)} 일',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset('images/periodLength.png',width: 40),
                    Padding(
                    padding:  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text('생리 기간 :   $periodLength 일',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                child: Row(
                  children: [
                    Image.asset('images/nextPeriod.png',width: 40),
                    Padding(
                    padding:  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text('다음 생리 예정일 :  ${formatNextPeriodDay(nextPeriodDay)}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xff8b7ff5))),
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     '다음 생리 예정일: ${calculateDDay(nextPeriodDay)}',
                //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                //   ),
                // ),
              ],
            ),
          const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.to(const Home()),
              style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: const Color(0xff8b7ff5),
                  ), 
              child: Text(
                '홈으로',
                style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => Get.to(const periodCycleChart()),
              style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: const Color(0xff8b7ff5),
                  ), 
              child: Text(
                '생리주기 기록보기',
                style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}



// ---Functions---

// Handle page change (Change of Months)
_onPageChanged(DateTime focusedDay) {
  // Update the _focusedDay value
  _focusedDay = focusedDay;

  // Calculate temporary range values based on the original range start
  if (_rangeStart != null) {
    // Check if focusedDay is after _rangeStart
    if (focusedDay.isAfter(_rangeStart!)) {
      _tempRangeStart = calculateRangeStartForward(focusedDay);
    } else {
      _tempRangeStart = calculateRangeStartBackward(focusedDay);
    }
    _tempRangeEnd = _tempRangeStart!.add(Duration(days: periodLength - 1));
  }

  // Update the state to reflect the changes
  setState(() {});
}

DateTime? calculateRangeStartForward(DateTime focusedDay) {
  // Calculate the month difference between the focused day and the original range start
  int monthDiff = (focusedDay.year - _rangeStart!.year) * 12 + focusedDay.month - _rangeStart!.month;
  
  // Calculate the range start for the focused month based on the cycle length
  return _rangeStart!.add(Duration(days: monthDiff * cycleLength));
}




DateTime? calculateRangeStartBackward(DateTime focusedDay) {
  // Calculate the month difference between the focused day and the original range start
  int monthDiff = (_rangeStart!.year - focusedDay.year) * 12 + _rangeStart!.month - focusedDay.month;
  
  // Calculate the range start for the focused month based on the cycle length
  return _rangeStart;
  
}





_showNoDataDialogue(){
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: const Text("생리주기를 입력해주세요!"),
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



//CALCULATE THE NEXT PERIOD DATE
predictPeriodDate(){
// next period day: period cycle +- 7 days. 
nextPeriodDay = _rangeStart!.add(Duration(days: cycleLength));

print(nextPeriodDay);

setState(() {});
}


//CALCULATE D-DAY FROM CURRENT DATE
String calculateDDay(DateTime? nextPeriodDay) {
  if (nextPeriodDay != null) {
    // Calculate the difference in days
    int dDay = DateTime.now().difference(nextPeriodDay).inDays;
    // Check if it's positive or negative
    if (dDay >= 0) {
      return 'D-$dDay';
    } else {
      return 'D$dDay';
    }
  } else {
    return '';
  }
}



 retrievePeriodData() async {
  // Retrieve the email from GetStorage
  final box = GetStorage();
  String? email = box.read<String>('email');

  if (email == null) {
    print('Email not found in the box');
    return;
  }

  try {
    // Query Firestore to find the document with the specified email
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      // Document found for the specified email
      DocumentSnapshot document = querySnapshot.docs.first;
      final data = document.data() as Map<String, dynamic>?;
      // Check if the 'period' map exists
      if (data != null && data.containsKey('period')) {
        Map<String, dynamic> periodMap = data['period'] as Map<String, dynamic>;
        // Get all keys from periodMap and sort them in descending order
        List<String> keys = periodMap.keys.toList();
        keys.sort((a, b) => b.compareTo(a));
        if (keys.isNotEmpty) {
          // Get the latest key (first in the sorted list)
          String latestKey = keys.first;
          // Retrieve the latest period data array using the latest key
          List<dynamic>? latestPeriodData = periodMap[latestKey];
          if (latestPeriodData != null && latestPeriodData.length >= 3) {
            // Retrieve formatted date, period length, and cycle length
            String formattedDate = latestPeriodData[0] as String;
            periodLength = latestPeriodData[1] as int;
            cycleLength = latestPeriodData[2] as int;
            // Convert formatted date to DateTime
            _rangeStart = DateFormat('yyyy-MM-dd').parse(formattedDate);
            _rangeEnd = _rangeStart!.add(Duration(days: periodLength - 1));
            // Set the focused day to _rangeStart
            _focusedDay = _rangeStart!;
            // Initialize temporary range values
            _tempRangeStart = _rangeStart;
            _tempRangeEnd = _rangeEnd;

            // Update the calendar immediately after retrieving the data
            _onPageChanged(_rangeStart!);

            // Calculate next period date:
            predictPeriodDate();
            // Refresh the state to reflect the changes
            setState(() {});
            print('Latest period data retrieved and state updated');
          } else {
            // Handle case where period data is invalid or not present
            _showNoDataDialogue();
            print('No valid period data found for the latest key');
          }
        } else {
          // Handle case where there are no keys in the 'period' map
          _showNoDataDialogue();
          print('No keys found in the period map');
        }
      } else {
        // Handle case where the 'period' map is not present in the document
        _showNoDataDialogue();
        print('No period data found in the specified document');
      }
    } else {
      // Handle case where no document is found for the specified email
      _showNoDataDialogue();
      print('No document found with the specified email');
    }
  } catch (error) {
    print('Error retrieving data: $error');
  }
}


}//END