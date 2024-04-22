import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/database_handler.dart';
import 'package:ovary_app/vm/login_vm.dart';
import 'package:ovary_app/widget/body/login_widget.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginGetX());
    final databaseHandler = DatabaseHandler();

    return Scaffold(
      appBar: AppBar(
        title: const Text("로 그 인"),
      ),
      //db에 값이 있나없나 확인하려고 FutureBuilder사용!-> 로그인 분기가 필요없어져서(로그인페이지에 간편로그인 버튼 존재) LogInWidget();로 바로이동
      body: FutureBuilder<bool>(
        future: databaseHandler.hasEmailData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return 
                LogInWidget();
          }
        },
      ),
    );
  }
}