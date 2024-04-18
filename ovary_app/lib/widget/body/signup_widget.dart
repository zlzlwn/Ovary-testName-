import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController authController = TextEditingController();
  final TextEditingController passwordController1 = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('images/User2.png',
                width: 160,
              ),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: '아이디를 입력 하세요',
                border: OutlineInputBorder() 
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('One Day',
                style: TextStyle(
                  color: Colors.purple[300],
                  fontWeight: FontWeight.w900
                ),
              ),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: '인증번호',
                border: OutlineInputBorder() 
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('One Day',
                style: TextStyle(
                  color: Colors.purple[300],
                  fontWeight: FontWeight.w900
                ),
              ),
            ),
            TextField(
              controller: idController,
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
              controller: idController,
              decoration: const InputDecoration(
                labelText: '비밀번호를 다시 입력 하세요',
                border: OutlineInputBorder() 
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('One Day',
                style: TextStyle(
                  color: Colors.purple[300],
                  fontWeight: FontWeight.w900
                ),
              ),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: '닉네임을 입력 하세요',
                border: OutlineInputBorder() 
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('One Day',
                style: TextStyle(
                  color: Colors.purple[300],
                  fontWeight: FontWeight.w900
                ),
              ),
            ),
            ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}