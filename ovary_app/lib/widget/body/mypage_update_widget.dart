import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';
import 'package:ovary_app/vm/signup_vm.dart';

class MypageUpdateWidget extends StatelessWidget {
  MypageUpdateWidget({super.key});

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();

//값 사용
  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  //함수사용
  final mypageUpdateVMFunction = MypageUpdateVM();
  //중복체크 함수
  final SignUpGetX signUpGetX = Get.put(SignUpGetX());
  // Gallery에서 사진 가져오기
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  File? imgFile;

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
              SizedBox(
                //sizebox는 width,height의 최소값으로 계산한다!
                //MediaQuery 코드 필수임 (핸드폰마다의 크기를 계산한다)
                width: MediaQuery.of(context).size.width,
                // /2 하는 이유는 핸드폰 전체에 대한 비율이기때문에 /2 안하면 핸드폰 화면 밖으로 넘어가 버림
                height: MediaQuery.of(context).size.width / 2,
                child: Center(
                  child: imageFile == null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(controller.imagepath),
                          radius: 100,
                        )
                      : Image.file(File(imageFile!.path) //null들어갈수도 있어서 ! 붙임
                          ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    getImageFromDevice(ImageSource.gallery);
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
                    'Gallery에서 사진 불러오기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: '이메일(수정불가)', border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                      labelText: '닉네임을 입력하세요', border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  onChanged: (value) {
                    passwordCheck();
                  },
                  controller: passwordController1,
                  decoration: const InputDecoration(
                      labelText: '비밀번호를 입력 하세요', border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextField(
                  onChanged: (value) {
                    passwordCheck();
                  },
                  controller: passwordController2,
                  decoration: const InputDecoration(
                      labelText: '비밀번호를 다시 입력 하세요',
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                child: Obx(() => Row(
                      children: [
                        Text(
                          signUpGetX.pwCheckResult.value,
                          style: TextStyle(
                            color: signUpGetX.pwCheckResult.value == '일치'
                                ? Colors.blue
                                : signUpGetX.pwCheckResult.value == '불일치'
                                    ? Colors.red
                                    : Colors.green,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    )),
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

  serchInfo() {
    print("-----------------------");
    print("-----------------------");
    print("-----------------------");
    print(mypageUpdateVM.nickname);
    print(mypageUpdateVM.email);
    nicknameController.text = mypageUpdateVM.nickname;
    emailController.text = mypageUpdateVM.email;
  }

  checkpassword() {
    if (passwordController1.text == passwordController2.text) {
      print("일치");
      //비밀번호 값 vm에 저장
      mypageUpdateVM.password1 = passwordController1.text;
      mypageUpdateVM.password2 = passwordController2.text;
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
                // 'nickname': doc['profile'],
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
      mypageUpdateVM.nickname = nicknameController.text;
      print(mypageUpdateVM.nickname);
      // 업데이트 작업 수행
      await FirebaseFirestore.instance
          .collection('user')
          .doc(document.id) // 문서 ID 사용
          .update({
        'email': mypageUpdateVM.email,
        'password': mypageUpdateVM.password1,
        'nickname': mypageUpdateVM.nickname,
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

  passwordCheck() {
    // 빈칸일때
    if (passwordController1.text.isEmpty || passwordController2.text.isEmpty) {
      signUpGetX.passwordCheck(
          passwordController1.text, passwordController2.text);
    }
    // 입력했을때
    if (passwordController1.text.isNotEmpty &&
        passwordController2.text.isNotEmpty) {
      signUpGetX.passwordCheck(
        passwordController1.text,
        passwordController2.text,
      );
    }
  }

  getImageFromDevice(imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      imageFile = null;
    } else {
      imageFile = XFile(pickedFile.path); //경로 들어온거를 이미지로 바꿔서 띄어준다
    }
  }
}
