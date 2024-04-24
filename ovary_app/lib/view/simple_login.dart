import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/database_handler.dart';
import 'package:ovary_app/vm/login_vm.dart';
import 'package:ovary_app/widget/body/login_widget.dart';
import 'package:ovary_app/widget/body/simpleloginwidget.dart';

class SimpleLogIn extends StatelessWidget {
  SimpleLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginGetX());
    final databaseHandler = DatabaseHandler();

    return Scaffold(
      appBar: AppBar(
        title: const Text("간 편 로 그 인"),
      ),
      //db에 값이 있나없나 확인하려고 FutureBuilder사용!
      body: FutureBuilder<bool>(
        future: databaseHandler.hasEmailData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            
            return 
                SimpleLoginWidget();
                
          }
        },
      ),
    );
  }
}