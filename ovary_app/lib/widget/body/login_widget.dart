import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/users.dart';
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

  final box = GetStorage();

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
                  padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                  child: TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                        labelText: '아이디를 입력 하세요', border: OutlineInputBorder()),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Get.to(const SignUp());
                        },
                        child: const Text(
                          '  아이디 찾기',
                          style: TextStyle(
                              color: Color(0xff8b7ff5),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
                          // Get.to(const SignUp());
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
                      backgroundColor: Color(0xff8b7ff5),
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
  loginAction(LoginGetX controller) async {
    controller.id = idController.text.trim();
    controller.password = passwordController.text.trim();

    final loginCheck = FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: controller.id)
        .where('password', isEqualTo: controller.password)
        // .snapshots();
        .get();

    final loginData = await loginCheck; // Future를 해결하여 데이터를 가져옵니다.
    final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.
    print(list);
//-----------------------------sqlite 입력부분
    if (list.isEmpty) {
      print('다시 입력');

      //firebase  로그인 성공시
    } else {
      final email = controller.id; // 입력한 이메일 값 가져오기

      // SQLite 데이터베이스에 사용자 정보 저장---- 이메일값이 같은 값이 있으면 insert 안시키게 변경필요!
      final databaseHandler = DatabaseHandler();
      final user = Users(email: email);
      await databaseHandler.insertUsers(user);

      //db에서 정보 가져오기
      // final users = await databaseHandler.queryUsers();

      checkLogin();

      checkPasswordBoolValue(databaseHandler);
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
    result == 0 ? Get.to(SimplePasswordInssert()) : Get.to(const Home());
  }
} // End