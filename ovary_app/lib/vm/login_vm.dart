import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/view/mypage_menu.dart';

class LoginGetX extends GetxController{
  String id = "";
  String password = "";
  
  

  //홈에서 로그인 페이지로 갈때 사용하는 dialog
    logoutDialog(context){
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, 
      content: Text(
        '로그아웃이 필요한 서비스입니다.',
        style: TextStyle(
          color: Colors.black, 
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            Get.to(MypageMenu());
          },
          child: Text(
            '확인',
            style: TextStyle(
              
            ),
          ),
        ),
      ],
    );
  },
);

  }
}