import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/hospital_likelist.dart';
import 'package:ovary_app/view/login.dart';
import 'package:ovary_app/view/mypage_menu.dart';
import 'package:ovary_app/widget/appbar/weight_chart.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: 
              Text("유저 사진 들어올 자리"),
              // CircleAvatar(
              //   backgroundImage: AssetImage('images/turtle.jpeg'),
              // ),
              accountName: Text(
                "김땡땡님(db Nickname들어올자리)",
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              accountEmail: Text(""),
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.local_hospital,
                color: Colors.black,
              ),
              title: Text("찜 병원보기"),
              onTap: () {
                Get.to(HospitalLikeList());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_sharp,
              ),
              title: Text("마이페이지"),
              onTap: () {
                Get.to(MypageMenu());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bar_chart_rounded,
              ),
              title: const Text("나의 체중 변화"),
              onTap: () {
                if(box.read('email') == '' || box.read('email') == null ){
                  buttonDialog();
                } else {
                  print(box.read('email'));
                  Get.back();
                  Get.to(const WeightChart());
                }
              },
            ),
          ],
        ),
      );
  }

  // alert 창
  buttonDialog() {
    Get.defaultDialog(
      title: '알림',
      middleText: '로그인이 필요한 페이지입니다.',
      barrierDismissible: false,
      backgroundColor: Colors.pink[100],
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
            Get.to(const LogIn());
          }, 
          child: const Text(
            '로그인하기',
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 64, 87, 235),
              fontWeight: FontWeight.bold
            ),
          )
        )
      ]
    );
  }
}