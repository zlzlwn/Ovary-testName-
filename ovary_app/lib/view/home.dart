
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
        title: Image.asset('images/appNamePurple.png',
          width: 200,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              onPressed: () {
                
                Get.to( LogIn());
              },
              icon: Image.asset(
                 "images/user.png",
                 width: 30,
              ),
            ),
          ),
          
        ],
      ),
      body: HomeWidget(),
      drawer: HomeDrawer(),
    );
  }
}