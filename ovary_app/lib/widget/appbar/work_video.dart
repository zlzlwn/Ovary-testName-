import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/widget/body/work_video_widget.dart';

class WorkVideo extends StatelessWidget {
  const WorkVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '운동영상',
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
      body: const WorkVideoWidget(),
    );
  }
}