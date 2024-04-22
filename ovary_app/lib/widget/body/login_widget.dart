import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/find_password.dart';
import 'package:ovary_app/view/home.dart';
import 'package:ovary_app/view/signup.dart';
import 'package:ovary_app/view/sim_pass_insert.dart';
import 'package:ovary_app/view/simple_login.dart';
import 'package:ovary_app/vm/database_handler.dart';
import 'package:ovary_app/vm/login_vm.dart';

class LogInWidget extends StatelessWidget {
  LogInWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginGetX mcontroller = Get.put(LoginGetX());

  final box = GetStorage();
  late int resultValue; 
  late int pwValue;
  final databaseHandler = DatabaseHandler();
  late final email;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<LoginGetX>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'images/OneDayLogoPurple.png',
                  width: 300,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                  child: TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                        labelText: '아이디를 입력 하세요', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: '비밀번호를 입력 하세요',
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const FindPassword());
                        },
                        child: const Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                              color: Color(0xff8b7ff5),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('아직 계정이 없으세요?'),
                      GestureDetector(
                        onTap: () {
                          Get.to(const SignUp());
                        },
                        child: const Text(
                          '  회원 가입하기',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: GestureDetector(
                    onTap: () async {
                      final databaseHandler = DatabaseHandler();
                      bool hasEmail = await databaseHandler.hasEmailData();
                      print(hasEmail);
                      hasEmail ? Get.to(SimpleLogIn()) : print('이메일 값이 없습니다.');
                    },
                    child: const Text(
                      '간편 로그인하기',
                      style: TextStyle(
                        color: Color(0xff8b7ff5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    loginAction(controller);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff8b7ff5),
                      foregroundColor: Colors.white),
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- Functions ---
  //log인 시 textfield에 입력된 id값으로 db에 있는 id값을 찾는 함수
  // loginAction(LoginGetX controller) async {
  //   controller.id = idController.text.trim();
  //   controller.password = passwordController.text.trim();

  //   // 1. firebase에서 id, pw값 체크하기 위함
  //   final loginCheck = await FirebaseFirestore.instance
  //       .collection('user')
  //       .where('email', isEqualTo: controller.id)
  //       .where('password', isEqualTo: controller.password)
  //       // .snapshots();
  //       .get();

  //   //final loginData = await loginCheck; // Future를 해결하여 데이터를 가져옵니다.
  //   //final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.
  //   //print('dddd : $list');

  //   // 2. 조회되는 값이 없을 때, alert창
  //   if (loginCheck.docs.isEmpty) {
  //       buttonDialog();


  //   } else {                        //3. Firebase에 회원정보가 있을 떄
  //     final email = controller.id; // 입력한 이메일 값 가져오기
      

  //     // 4. SQLite에서 입력한 아이디 값이 있는지 체크 (0 : 없음, 1 : 있음)
  //     int resultValue = await databaseHandler.checkEmailInfo(email);// 4-2. SQLite에 해당 아이디에 PW가 있는지 없는지 체크 (0 : 없음, 1 : 있음)
  //     if(resultValue == 0) {
  //       // 5-1. SQLite에 아이디가 없을 때 SQLite에 아이디값 insert 처리하기
  //       await databaseHandler.insertUsers(email); 
      
  //     } else {
  //       // 5-2. SQLite에 아이디가 있을 때 SQLite에 해당 아이디의 비번이 있는지 체크
  //       int pwValue = await databaseHandler.checkPwInfo(email);

  //       //간편비번 없으면
  //       if(pwValue == 0){

  //         //간편비번 로그인 페이지로 이동
  //         Get.back(); 
  //         Get.to(const SimplePasswordInssert());

  //       } else {

  //         //간편로그인 비번 있으면, storage에 아이디값 저장 후, home 화면
  //         box.write('email',email); Get.back();
  //       }
  //     }
  //     // //db에서 정보 가져오기
  //     // final users = await databaseHandler.queryUsers();

  //     // checkLogin();

  //     // checkPasswordBoolValue(databaseHandler);
  //   }
  // }


  Future<void> loginAction(LoginGetX controller) async {
  mcontroller.id = idController.text.trim();
  mcontroller.password = passwordController.text.trim();

  final loginCheck = await FirebaseFirestore.instance
      .collection('user')
      .where('email', isEqualTo: mcontroller.id)
      .where('password', isEqualTo: mcontroller.password)
      .get();

  if (loginCheck.docs.isEmpty) {
    buttonDialog();
  } else {
    email = mcontroller.id;
    int resultValue = await databaseHandler.checkEmailInfo(email);

    if (resultValue == 0) {
      await databaseHandler.insertUsers(email);
    } else {
      int pwValue = await databaseHandler.checkPwInfo(email);

      if (pwValue == 0) {
        Get.back();
        Get.to(const SimplePasswordInssert());
      } else {
        box.write('email', email);
        Get.back();
      }
    }
  }
}


  checkLogin() {
    box.write('email', idController.text);
  }

  checkPasswordBoolValue(databaseHandler) async {
    //sqlite에 간편 비밀번호 값이 있으면 home으로 이동, 없으면 simplepasswordinsert화면으로 이동!
    print("패스워드 불값 확인${databaseHandler.hasPassword().toString()}");

    int result = await databaseHandler.hasPassword();
    print("패스워드 불값 확인: $result");
    result == 0 ? Get.to(const SimplePasswordInssert()) : Get.to(const Home());
  }


  //회원정보 없을 때 alert창
  buttonDialog() {
  Get.defaultDialog(
      title: '알림',
      middleText: '입력하신 정보가 없습니다.',
      barrierDismissible: false,
      backgroundColor: Colors.yellowAccent,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
            Get.to(const SignUp());
          }, 
          child: const Text('회원가입 하기')
        )
      ]
    );
  }


} // End