import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/weight_chart_widget.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '나의 체중 변화',
          style: TextStyle(
            fontSize: 25
          ),
        ),
        backgroundColor: Colors.pink[100],
      ),
      body: const WeightChartWidget(),
    );
  }
}