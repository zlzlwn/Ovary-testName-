import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VmSnackBar extends GetxController{
  
  String title = '';
  String content = '';
  Color textColor  = Colors.black;
  Color bgColor  = Colors.white;

  runSnackBar() {
    Get.snackbar(
      title, 
      content,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      colorText: textColor,
      backgroundColor: bgColor
    );

    update();
  }

}