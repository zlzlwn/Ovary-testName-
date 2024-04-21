import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';

class MypageUpdateWidget extends StatelessWidget {
  MypageUpdateWidget({super.key});

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

//값 사용
  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  //함수사용
  final mypageUpdateVMFunction = MypageUpdateVM();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    serchInfo();
    loadingUserInfoAction();
    return Center(
      child: GetBuilder<MypageUpdateVM>(
        builder: (controller) {
          return Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(controller.imagepath),
                radius: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                      labelText: '닉네임', border: OutlineInputBorder()),
                  readOnly: true,
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: '이메일', border: OutlineInputBorder()),
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
                     updateAction();
                    // mypageUpdateVMFunction.updateAction();
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

serchInfo(){
  print("-----------------------");
  print("-----------------------");
  print("-----------------------");
  print(mypageUpdateVM.nickname);
  print(mypageUpdateVM.email);
   nicknameController.text=mypageUpdateVM.nickname; 
   emailController.text=mypageUpdateVM.email; 
}
  checkpassword() {
    if (password1Controller.text == password2Controller.text) {
      print("일치");
      //비밀번호 값 vm에 저장
      mypageUpdateVM.password1 = password1Controller.text;
      mypageUpdateVM.password2 = password2Controller.text;
    } else {
      print("불일치");
    }
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
      String email = dataList1[0]['email'];
      String nickname = dataList1[0]['nickname'];
      String profile = dataList1[0]['profile'];
      //vm의 변수에 할당
      mypageUpdateVM.email = email;
      mypageUpdateVM.nickname = nickname;
      mypageUpdateVM.imagepath = await profile;

      print("-------------------------------------------");
      print("바뀐 후  값${mypageUpdateVM.imagepath}");
      mypageUpdateVM.show();
      //변수 바꾸고 나서 텍스트 필드에 변수 할당
      nicknameController.text = await mypageUpdateVM.nickname;
      emailController.text = await mypageUpdateVM.email;
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

      mypageUpdateVM.email = data['email'];
      mypageUpdateVM.nickname = data['nickname'];
      mypageUpdateVM.imagepath = data['profile'];

      // 업데이트 작업 수행
      await FirebaseFirestore.instance
          .collection('user')
          .doc(document.id) // 문서 ID 사용
          .update({
        'email': mypageUpdateVM.email,
        'password': mypageUpdateVM.password1,
        // 프로필 필드가 있으면 업데이트
        if (mypageUpdateVM.imagepath != null)
          'profile': mypageUpdateVM.imagepath,
        // 다른 필드 업데이트
      }).then((_) {
        print("업데이트 성공");
        Get.back();
      }).catchError((error) {
        print("업데이트 실패: $error");
      });
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }
  
}
