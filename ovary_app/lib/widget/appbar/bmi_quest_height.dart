

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/body/bmi_quest_height_widget.dart';

class BmiQuestHeight extends StatelessWidget {
  const BmiQuestHeight({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: const Icon(Icons.keyboard_arrow_left)
        ),
      ),
      body: BmiQuestHeightWidget(),
    );
  }
}