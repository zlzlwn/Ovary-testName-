import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'package:ovary_app/view/cycle_history.dart';

import 'package:get_storage/get_storage.dart';

import 'package:ovary_app/view/hospital_likelist.dart';
import 'package:ovary_app/view/login.dart';
import 'package:ovary_app/view/mypage_menu.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';
import 'package:ovary_app/widget/appbar/weight_chart.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({Key? key}) : super(key: key);

  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    //이미지를 로딩한후에 드로우어를 빌드하기위해 FutureBuilder사용! 내가 무슨 부귀영화를 누리려고 stl로 했나...
    return FutureBuilder(
      future: mypageUpdateVM.loadingUserInfoAction(), 
     builder: (context, snapshot) {
      //future가 다 실행되었는지 확인아는 조건문임!
  if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
  } else {
    if (box.read('email') != null) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(mypageUpdateVM.imagepath),
                radius: 100,
              ),
              accountName: Text(
                mypageUpdateVM.nickname,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(""),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
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
                print(box.read('email'));
                box.read('email') == null
                    ? mypageUpdateVM.loginDialog(context)
                    : Get.to(MypageMenu());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.water_drop,
              ),
              title: Text("나의 생리주기 차트"),
              onTap: () {
                print(box.read('email'));
                box.read('email') == null
                    ? mypageUpdateVM.loginDialog(context)
                    : Get.to(const periodCycleChart());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bar_chart_rounded,
              ),
              title: const Text("나의 체중 변화"),
              onTap: () {
                box.read('email') == null
                    ? mypageUpdateVM.loginDialog(context)
                    : Get.back(); Get.to(const WeightChart());
              },
            ),
            
          ],
        ),
      );
    } else {
          return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(LogIn());
              },
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  "로그인이 필요합니다",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(""),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
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
                print(box.read('email'));
                box.read('email') == null
                    ? mypageUpdateVM.loginDialog(context)
                    : Get.to(MypageMenu());
              },
            ),
            
            ListTile(
              leading: const Icon(
                Icons.bar_chart_rounded,
              ),
              title: const Text("나의 체중 변화"),
              onTap: () {
                box.read('email') == null
                    ? mypageUpdateVM.loginDialog(context)
                    : Get.to(const WeightChart());
              },
            ),
          ],
        ),
      );
    }
  }
},

    );
  }


    loadingUserInfoAction() async {
    print("바뀌기 전 값${mypageUpdateVM.imagepath}");
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: box.read('email'))
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      //firebase에서 받아온 데이터를 list로 변환
      final List<Map<String, dynamic>> dataList1 = querySnapshot.docs
          .map((doc) => {
                'email': doc['email'],
                'nickname': doc['nickname'],
                'profile': doc['profile'],
              })
          .toList();
      //받아온 list데이터를 풀어서 뷰 모델에 저장함
      mypageUpdateVM.email = dataList1[0]['email'];
      mypageUpdateVM.nickname = dataList1[0]['nickname'];
      mypageUpdateVM.imagepath = dataList1[0]['profile'];

      print("-------------------------------------------");
      print("바뀐 후  값${mypageUpdateVM.imagepath}");
      mypageUpdateVM.show();
      //변수 바꾸고 나서 텍스트 필드에 변수 할당
      print("email값 확인 ${mypageUpdateVM.email}");
      print("nickname 확인 ${mypageUpdateVM.nickname}");
      print("imagepath 확인 ${mypageUpdateVM.imagepath}");
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }
}
