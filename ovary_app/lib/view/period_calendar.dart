import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
    

    @override
    void initState() {
        super.initState();
        retrievePeriodData();
    }

    retrievePeriodData() async {

    // // Hardcoded email for testing purposes 
    // String email = 'chosun@naver.com';

    // Get the email from the box
    final box = GetStorage();
    String? email = box.read<String>('email');

    if (email == null) {
        // Email not found in the box, handle appropriately
        print('Email not found in the box');
        return;
    }

    try {

        // Query Firestore to find the document that matches the hardcoded email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        // If a document is found, extract the period data
        if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot document = querySnapshot.docs.first;
            List<dynamic> periodData = document['period'] as List<dynamic>;

            // Extract formattedDate, periodLength, and cycleLength from the array
            String formattedDate = periodData[0] as String;
            periodLength = periodData[1] as int;
            cycleLength = periodData[2] as int;

            // Parse formattedDate to DateTime
            DateTime rangeStart = DateFormat('yyyy-MM-dd').parse(formattedDate);
            DateTime rangeEnd = rangeStart.add(Duration(days: periodLength - 1));

            // Update the state with the retrieved values
            setState(() {
                _rangeStart = rangeStart;
                _rangeEnd = rangeEnd;
                _focusedDay = rangeStart;
            });

            print('Period data retrieved and state updated');
        } else {
            print('No document found with the specified email');
        }
        } catch (error) {
            print('Error retrieving data: $error');
        }
}


@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('나의 생리주기 캘린더'),
            backgroundColor: Colors.pink[100],
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
            startingDayOfWeek: StartingDayOfWeek.monday,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            rangeStartDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withOpacity(0.8),
            ),
            rangeHighlightColor: Colors.pink.withOpacity(0),
            rangeEndDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent.withOpacity(0.8),
            ),
            withinRangeDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink.withOpacity(0.2),
            ),
            todayDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
            ),
            ),

            onFormatChanged: (format) {
                if (_calendarFormat != format) {
                    _calendarFormat = format;
                    setState(() {});
                }
            },
            onPageChanged: _onPageChanged,
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
                      color: Colors.pinkAccent.withOpacity(0.8),
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
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  ),
                ),
              const SizedBox(width: 8),
              const Text('오늘날짜', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('생리 시작일:   $_rangeStart', style: const TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('생리 기간:     $periodLength 일',style: const TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(' 생리 주기:    $cycleLength 일',style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
        const SizedBox(height: 95),
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


    // ---Functions---

    // Handle page change (Change of Months)
    void _onPageChanged(DateTime focusedDay) {
        // Calculate the days difference between the new focused day and the previous focused day
        int daysDifference = focusedDay.difference(_focusedDay).inDays;

        // Adjust rangeStart and rangeEnd based on the cycle length and days difference
        if (_rangeStart != null) {
            // Calculate the new range start based on the days difference and cycle length
            _rangeStart = focusedDay.add(Duration(days: daysDifference));

            // Calculate the new range end based on the new range start and period length
            _rangeEnd = _rangeStart!.add(Duration(days: periodLength - 1));
        } else {
            // If there is no range start, initialize it with the new focused day
            _rangeStart = focusedDay;
            _rangeEnd = focusedDay.add(Duration(days: periodLength - 1));
        }

        // Update the focused day
        _focusedDay = focusedDay;

        // Trigger a state update to refresh the UI
        setState(() {});
    }




}//END
