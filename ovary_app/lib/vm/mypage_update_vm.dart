import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/login.dart';

class MypageUpdateVM extends GetxController {
  String nickname = "";
  String email = "";
  String password1 = "";
  String password2 = "";
  String imagepath = "";
  String selectedImagePath = "";
  

    final box = GetStorage();
 show() async {
  update();
 }

loadingUserInfoAction() async {
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
      email = await dataList1[0]['email'];
      nickname = dataList1[0]['nickname'];
      imagepath = await dataList1[0]['profile'];
      box.write('nick',dataList1[0]['nickname']);
      


      update();
      //변수 바꾸고 나서 텍스트 필드에 변수 할당
     
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }


  updateAction() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: box.read('email'))
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot document = querySnapshot.docs[0]; // 첫 번째 문서 사용
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      email = data['email'];
      nickname = data['nickname'];
      imagepath = data['profile'];

      // 업데이트 작업 수행
      await FirebaseFirestore.instance
          .collection('user')
          .doc(document.id) // 문서 ID 사용
          .update({
        'email': email,
        'password': password1,
        // 프로필 필드가 있으면 업데이트
        if (imagepath != null)
          'profile': imagepath,
        // 다른 필드 업데이트
      }).then((_) {
        Get.back();
      }).catchError((error) {
        print("업데이트 실패: $error");
      });
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }

  loginDialog(context){
    
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      content: Text(
        '로그인이 필요한 서비스입니다.',
        style: TextStyle(
          color: Colors.black, 
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
            Get.to(LogIn());
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