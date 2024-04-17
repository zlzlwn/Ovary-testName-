import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/period_calendarwidget.dart';

class PeriodCalender extends StatelessWidget {
  const PeriodCalender({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: PeriodCalenderWidget(),
    );
  }
}