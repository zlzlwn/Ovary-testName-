import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovary_app/vm/signup_vm.dart';

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController authController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

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
          child: Column(
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
                    // getImageFromDevice(ImageSource.gallery);
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
                        emailCheck();
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
          ),
        ),
      ),
    );
  }

  // --- Functions ---
  //   getImageFromDevice(imageSource) async {
  // final XFile? pickedFile = await picker.pickImage(source: imageSource);
  // if(pickedFile == null) {
  //   imageFile = null;
  // }
  // else {
  //   imageFile = XFile(pickedFile.path);
  //   imgFile = File(imageFile!.path);
  // }
  // // setState(() {});
  // }

  emailCheck() {
    
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