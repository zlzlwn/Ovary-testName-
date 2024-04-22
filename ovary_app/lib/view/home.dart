
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/login.dart';
import 'package:ovary_app/vm/login_vm.dart';
import 'package:ovary_app/widget/body/home_drawer.dart';
import 'package:ovary_app/widget/body/homewidget.dart';

class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/appNamePurple.png',
          width: 180,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              onPressed: () {
                loginAction(context);
                
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
  loginAction(context){
    final box = GetStorage();
    final LoginGetX loginGetX = Get.put(LoginGetX());

    box.read("email")==null
    ?Get.to( LogIn())
    :loginGetX.logoutDialog(context);
    
  }
}