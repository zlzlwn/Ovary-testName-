import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/hospital_likelist.dart';
import 'package:ovary_app/view/mypage_menu.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';

class HomeDrawer extends StatelessWidget {
   HomeDrawer({super.key});
final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
              currentAccountPicture: 
               CircleAvatar(
                backgroundImage:
                NetworkImage(mypageUpdateVM.imagepath),
                    
                radius: 100,
              ),
              accountName: Text(
                mypageUpdateVM.nickname,
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
           
          ],
        ),
      );
  }
}