import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovary_app/vm/signup_vm.dart';
// import 'package:ovary_app/widget/image_widget/image_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController authController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  // 중복 확인후 중복이 없으면 readOnly로 바꿔주기
  // final signUpController = Get.put(SignUpController());
  // final SignUpController signUpController2 = SignUpController(); // 직접 생성

  final SignUpGetX signUpGetX = Get.put(SignUpGetX());

    // Gallery에서 사진 가져오기
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  File? imgFile;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<SignUpGetX>(
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/6,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 188, 186, 186),
                      ),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/4.8*2,
                      height: 150,
                      child: imageFile == null
                      ? Center(
                          child: Image.asset('images/${signUpGetX.defaultImage}',
                            width: 130,
                          )
                        )
                      : Image.file(File(imageFile!.path)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: OutlinedButton(
                      onPressed: () {
                        getImageFromDevice(ImageSource.gallery);
                      },
                      child: const Text('사진 변경하기')
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.46,
                        child: TextField(
                          controller: idController,
                          // readOnly: signUpController.idReadOnly.value,
                          decoration: const InputDecoration(
                            labelText: '아이디를 입력 하세요',
                            border: OutlineInputBorder() 
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            emailCheck(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                            foregroundColor: const Color.fromRGBO(139, 127, 245, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13)),
                          fixedSize: Size( MediaQuery.of(context).size.width / 5,
                            MediaQuery.of(context).size.height / 15
                          ),
                        ), 
                          child: const Text('중복 확인',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('One Day',
                          style: TextStyle(
                            color: Colors.purple[300],
                            fontWeight: FontWeight.w900
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      passwordCheck();
                    },
                    controller: passwordController1,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) {
                      passwordCheck();
                    },
                    controller: passwordController2,
                    decoration: const InputDecoration(
                        labelText: '비밀번호를 다시 입력 하세요',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          signUpGetX.pwCheckResult.value,
                          style: TextStyle(
                            color: signUpGetX.pwCheckResult.value == '일치'
                                ? Colors.blue
                                : signUpGetX.pwCheckResult.value == '불일치'
                                  ? Colors.red
                                  : Colors.green
                                  ,
                            fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: nicknameController,
                    decoration: const InputDecoration(
                      labelText: '닉네임을 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        insertProfileImage(File(imageFile!.path));
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[300],
                        foregroundColor: Colors.white
                      ),
                      child: const Text('회원가입',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),  
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  // --- Functions ---
    getImageFromDevice(imageSource) async {
  final XFile? pickedFile = await picker.pickImage(source: imageSource);
  if(pickedFile == null) {
    imageFile = null;
  }
  else {
   imageFile = XFile(pickedFile.path);
      signUpGetX.selectedImagePath = imageFile!.path;
      print(signUpGetX.selectedImagePath);
      signUpGetX.update();
  }
  }

  Future<void> insertProfileImage(File imageFile) async {
  final email = idController.text;
  final storage = firebase_storage.FirebaseStorage.instance;

  // Firebase Storage에 이미지 업로드 -> 이메일 기준으로 사진이름이 정해지기 때문에 자동으로 덮어쓰기가 된다!
  final imageRef = storage.ref().child('images/${email}.jpg');
  await imageRef.putFile(imageFile);

  // Firebase Storage에서 업로드된 이미지의 다운로드 URL 가져오기
  final downloadURL = await imageRef.getDownloadURL();

  // Firestore 문서에 다운로드 URL 업데이트
  final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('user')
      .where('email', isEqualTo: email)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    final DocumentSnapshot document = querySnapshot.docs[0];
final existingImageURL = document.get('profile');
   await FirebaseFirestore.instance
  .collection('user')
  .doc(document.id) // 문서 ID 사용
  .set({
    'profile': downloadURL,
  }, SetOptions(merge: true));

  } else {
    // 데이터가 없는 경우
    print('데이터 없음');
  }
}
  
  bool isValidEmail(String email) {
    // 이메일 주소의 유효성을 검사하는 정규식
    // 해당 정규식은 일반적인 이메일 주소 형식을 검증합니다.
    String pattern =
        r'^[a-z0-9._]+@[a-z]+\.[a-z]{2,3}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void emailCheck(BuildContext context) {
  String email = idController.text;
  if (isValidEmail(email)) {
    // 이메일이 유효한 경우 중복 확인 로직 실행
    // 여기에 중복 확인 로직을 추가하세요
    // signUpGetX.setIdReadOnly(true);
    //     isIdReadOnly = true;
  } else {
    // 이메일이 유효하지 않은 경우 사용자에게 다이얼로그 표시
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('유효하지 않은 이메일'),
        content: const Text('올바른 이메일 주소를 입력해주세요.\n예 : oneday@oneday.com'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
    // 이메일을 다시 입력하도록 입력 필드를 초기화
    idController.clear();
    }
  }

  passwordCheck() {
    // 빈칸일때
    if (passwordController1.text.isEmpty || 
        passwordController2.text.isEmpty) {
      signUpGetX.passwordCheck(
        passwordController1.text, 
        passwordController2.text
      );
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
} // End