import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovary_app/view/home.dart';
import 'package:ovary_app/vm/signup_vm.dart';
// import 'package:ovary_app/widget/image_widget/image_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();


  final SignUpGetX signUpGetX = Get.put(SignUpGetX());
  final SignUpGetX boolSignUpGetX = Get.put(SignUpGetX());

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
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 188, 186, 186),
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 4.8 * 2,
                    height: 150,
                    child: imageFile == null
                      ? Center(
                          child: Image.asset(
                            'images/${signUpGetX.defaultImage}',
                            width: 130,
                          )
                        )
                      : Image.file(File(signUpGetX.selectedImagePath)),
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
                    Expanded(
                      child: TextField(
                        controller: idController,
                        readOnly: boolSignUpGetX.idReadOnly,
                        decoration: const InputDecoration(
                          labelText: '이메일을 입력 하세요',
                          border: OutlineInputBorder()
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                          foregroundColor: Color(0xff8b7ff5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)
                          ),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width / 5,
                            MediaQuery.of(context).size.height / 15
                          ),
                        ),
                        child: const Text(
                          '중복 확인',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                TextField(
                  onChanged: (value) {
                    passwordCheck();
                  },
                  controller: passwordController1,
                  obscureText: true,
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
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호를 다시 입력 하세요',
                    border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.text,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
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
                      // 회원정보 담기
                      imageCheck(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8b7ff5),
                      foregroundColor: Colors.white
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

  // --- Functions ---

    imageCheck(BuildContext context) {
      if (signUpGetX.selectedImagePath.isEmpty) {
        print('이미지 없음');
        showDialog(
          context: context, // 여기서 context를 전달해줍니다.
          builder: (context) => AlertDialog(
            title: const Text('이미지'),
            content: const Text('이미지를 넣어주세요.'),
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
      idController.text = '';
      passwordController1.text = '';
      passwordController2.text = '';
      nicknameController.text = '';
    } else {
      // 중복 확인을 거치지 않았을 때만 회원가입 처리
    if (!boolSignUpGetX.idReadOnly) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('중복 확인'),
          content: const Text('이메일 중복 확인을 해주세요.'),
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
    } else {
      // 중복 확인을 거쳤을 때 회원가입 처리
      insertSignUp();
      insertProfileImage(File(imageFile!.path));
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('회원 가입'),
          content: const Text('회원 가입을 환영합니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.back();
                Get.back();
                Get.to(const Home());
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}


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

  void emailCheck(BuildContext context) async {
  String email = idController.text;
  if (isValidEmail(email)) {
    // 이메일이 유효한 경우 중복 확인 로직 실행
    // signUpGetX.setIdReadOnly(true);
    // isIdReadOnly = true;

    // 1. firebase에서 id, pw값 체크하기 위함
    final loginCheck = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: idController.text)
        // .snapshots();
        .get();

    final loginData = await loginCheck; // Future를 해결하여 데이터를 가져옵니다.
    final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.

    // 2. 조회되는 값이 없을 때, alert창
    if (loginCheck.docs.isEmpty) {
      buttonDialog();
      boolSignUpGetX.idReadOnly = true;

      boolSignUpGetX.updateState();
    //3. 회원정보가 있을 떄
    } else {           
      // ignore: unused_local_variable             
      final email = idController.text;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('이메일 중복'),
          content: const Text('존재하는 이메일이 있습니다.\n이메일을 변경하여 주세요.'),
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

  //회원정보 없을 때 alert창
  buttonDialog() {
  Get.defaultDialog(
      title: '알림',
      middleText: '사용 가능한 아이디입니다.',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          }, 
          child: const Text('확인')
        )
      ]
    );
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

  Future<void> insertSignUp() async {
    if (signUpGetX != null) {
      signUpGetX.email = idController.text.trim(); 
      signUpGetX.nickname = nicknameController.text.trim(); 
      signUpGetX.password1 = passwordController1.text.trim(); 

      // 현재 시간 가져오기
      DateTime now = DateTime.now();

      await FirebaseFirestore.instance
        .collection('user')
        .add({
          'email': signUpGetX.email,
          'nickname': signUpGetX.nickname,
          'password': signUpGetX.password1,
          'profile': '',
          'inserdate': now,
          'deletedate': '',
          'occurRate': '',
          'period': {},
        });
    }
  }
  
} // End