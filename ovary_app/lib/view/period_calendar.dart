
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/period_input.dart';
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
  late TextEditingController periodLengthController;
  late TextEditingController cycleLengthController;
  // Default period length
  int periodLength = 7; 
  // Default cycle length
  int cycleLength = 28; 

  // Initialize
  @override
  void initState() {
    super.initState();
    periodLengthController = TextEditingController();
    cycleLengthController = TextEditingController();
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
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
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
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                  _calendarFormat = format;
                setState(() {});
              }
            },
            onPageChanged:(focusedDay) {
              _onPageChanged(focusedDay);
              // setState(() {
              // });
            },
            
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: periodLengthController,
                  decoration: const InputDecoration(
                    labelText: 'Period Length (days)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: cycleLengthController,
                  decoration: const InputDecoration(
                    labelText: 'Cycle Length (days)',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _handlePeriodLength();
                        _handleCycleLength();
                      }, 
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---Functions---


  _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      _focusedDay = focusedDay;
      _rangeStart = selectedDay;
      _rangeEnd = selectedDay.add(Duration(days: periodLength - 1));
    setState(() {
    });
  }

// CHANGING MONTH
_onPageChanged(DateTime focusedDay) {
    // Calculate the days difference between the new focused day and the previous focused day
    int daysDifference = focusedDay.difference(_focusedDay).inDays;

    // If a range start day is set, adjust it based on the cycle length and days difference
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


// PERIOD LENGTH 
  _handlePeriodLength() {
    // Parse period length from user input
    try {
        final int parsedPeriodLength = int.parse(periodLengthController.text);
        periodLength = parsedPeriodLength;
      setState(() {
      });
    } catch (e) {
      // Show an error message if input is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid input. Please enter a valid period length.'),
        ),
      );
    }
  }
  
  // CYCLE LENGTH
  _handleCycleLength(){
    // Parse period length from user input 
    try {
        final int parsedCycleLength = int.parse(cycleLengthController.text);
          cycleLength = parsedCycleLength;
        setState(() {
        });
        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Period and Cycle length set. Now select the start day on the calendar.'),
          ),
        );
      } catch (e) {
        // Show an error message if input is invalid
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid input. Please enter a valid cycle length.'),
          ),
        );
      }
  }


}//END
