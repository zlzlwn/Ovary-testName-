
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/login.dart';
import 'package:ovary_app/widget/body/home_drawer.dart';
import 'package:ovary_app/widget/body/homewidget.dart';

class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('앱로고 들어올 자리'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const LogIn());
            },
            icon: const Icon(Icons.login_sharp),
          ),
          
        ],
      ),
      body: HomeWidget(),
      drawer: HomeDrawer(),
    );
  }
}