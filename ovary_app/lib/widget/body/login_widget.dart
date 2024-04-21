import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/users.dart';
import 'package:ovary_app/view/home.dart';
import 'package:ovary_app/view/signup.dart';
import 'package:ovary_app/vm/database_handler.dart';
import 'package:ovary_app/vm/login_vm.dart';

class LogInWidget extends StatelessWidget {
  LogInWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder<LoginGetX>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('어 느 날',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 30,
                    fontWeight: FontWeight.w900
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text('One Day',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 40,
                    fontWeight: FontWeight.w900
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: '아이디를 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('아이디 찾기'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('비밀번호 찾기'),
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
                        child: Text('  회원 가입하기',
                          style: TextStyle(
                            color: Colors.purple[300],
                          ),
                        ),
                      ),
                    ],
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
                    backgroundColor: Colors.purple[300],
                    foregroundColor: Colors.white
                  ),
                  child: const Text('로그인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),  
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  // --- Functions ---
  //log인 시 textfield에 입력된 id값으로 db에 있는 id값을 찾는 함수
  loginAction(LoginGetX controller) async{
    controller.id = idController.text.trim();
    controller.password = passwordController.text.trim();

    final loginCheck = FirebaseFirestore
    .instance
    .collection('user')
    .where('email', 
    isEqualTo: controller.id)
    .where('password',
    isEqualTo: controller.password)
    // .snapshots();
    .get();

    final loginData = await loginCheck; // Future를 해결하여 데이터를 가져옵니다.
    final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.
    print(list);

    if(list.isEmpty) {
      print('다시 입력');
    }else {
      final email = controller.id; // 입력한 이메일 값 가져오기

    // SQLite 데이터베이스에 사용자 정보 저장
    final databaseHandler = DatabaseHandler();
    final user = Users(email: email);
    await databaseHandler.insertUsers(user);

    //db에서 정보 가져오기
        final users = await databaseHandler.queryUsers();

         for (final user in users) {
          print("sqlite 저장값 불러오기");
      print('Email: ${user.email}');
      print("sqlite 저장값 불러오기");
      print('Email: ${user.email}');
    }

      checkLogin();
      Get.to(const Home());
      print(box.read('email'));
      
    }
  }

  checkLogin() {
    box.write('email', idController.text);
  }

} // End