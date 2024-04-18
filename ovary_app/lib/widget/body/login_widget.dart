import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/signup.dart';

class LogInWidget extends StatelessWidget {
  LogInWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final box = GetStorage();
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
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
                checkLogin();
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
      ),
    );
  }

  // --- Functions ---
  checkLogin() {
    box.write('email', idController.text);
  }

} // End