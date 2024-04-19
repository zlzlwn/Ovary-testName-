import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/mypage_update.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';
import 'package:ovary_app/widget/body/stftwst.dart';

class MypageUpdateWidget extends StatelessWidget {
  MypageUpdateWidget({super.key});

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<MypageUpdateVM>(
        builder: (controller) {
          //view model에서 값을 받아오기 위해 사용
          testAction();
          return Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(mypageUpdateVM.imagepath)
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                      labelText: '닉네임들어갈 자리 (수정불가)',
                      border: OutlineInputBorder()),
                  readOnly: true,
                  keyboardType: TextInputType.text,
                ),
              ),
              Center(
                child: aa(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: '이메일들어갈 자리 (수정불가)',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  controller: password1Controller,
                  decoration: const InputDecoration(
                      labelText: '비밀번호를 입력 하세요', border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  controller: password2Controller,
                  decoration: const InputDecoration(
                      labelText: '비밀번호를 다시 입력 하세요',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    checkpassword();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(139, 127, 245, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 17),
                  ),
                  child: const Text(
                    '정보수정',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  checkpassword() {
    if (password1Controller.text == password2Controller.text) {
      print("일치");
      //비밀번호 값 vm에 저장
      mypageUpdateVM.password = password1Controller.text;
    } else {
      print("불일치");
    }
  }

  testAction() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: box.read('email'))
        .get();
    //firebase에서 받아온 데이터가 있으면 실행
    if (querySnapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataList1 = querySnapshot.docs
          .map((doc) => {
                'email': doc['email'],
                'nickname': doc['nickname'],
                'profile': doc['profile'],
              })
          .toList();
      String email = dataList1[0]['email'];
      String nickname = dataList1[0]['nickname'];
      String profile = dataList1[0]['profile'];
      print(email);
      mypageUpdateVM.email = email;
      mypageUpdateVM.nickname = nickname;
      mypageUpdateVM.imagepath = profile;
      print("vm에 잘 들어가는지 확인");
      print(mypageUpdateVM.email);
      print(mypageUpdateVM.nickname);
      print(mypageUpdateVM.imagepath);
      nicknameController.text = mypageUpdateVM.nickname;
      emailController.text = mypageUpdateVM.email;
    } else {
      // 데이터가 없는 경우
      print('No data found');
    }
  }
}
