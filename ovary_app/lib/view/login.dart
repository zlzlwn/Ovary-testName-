import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/login_vm.dart';
import 'package:ovary_app/widget/body/login_widget.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(LoginGetX());
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("로 그 인"),
      ),
      body: LogInWidget(),
    );
  }
}