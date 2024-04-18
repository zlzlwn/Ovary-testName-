import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/period_calendar_widget.dart';

class PeriodCalender extends StatelessWidget {
  const PeriodCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("period_calendar"),
      ),
      body: PeriodCalendarWidget()
    );
  }
}