import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FindPasswordWidget extends StatefulWidget {
  const FindPasswordWidget({super.key});

  @override
  State<FindPasswordWidget> createState() => _FindPasswordWidgetState();
}

class _FindPasswordWidgetState extends State<FindPasswordWidget> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController authController = TextEditingController();

  bool showAuthField = false; // 인증키 입력 필드를 보여줄지 여부
  String sentAuthKey = ''; // 전송된 인증키를 저장할 변수

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              'images/OneDayLogoPurple.png',
              width: 300,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 188, 186, 186),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      '이메일을 입력하여 주세요',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: idController,
                      decoration: const InputDecoration(
                          labelText: 'ex)oneday@oneday.com',
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        emailCheck(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8b7ff5),
                          foregroundColor: Colors.white),
                      child: const Text(
                        '인증키 발송',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            if (showAuthField)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 188, 186, 186),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: authController,
                        decoration: const InputDecoration(
                          labelText: '인증키를 입력하여 주세요',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: validateAuthKey,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff8b7ff5),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          '인증키 확인',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

 // --- Functions ---
  bool isValidEmail(String email) {
    // 이메일 주소의 유효성을 검사하는 정규식
    // 해당 정규식은 일반적인 이메일 주소 형식을 검증합니다.
    String pattern = r'^[a-z0-9._]+@[a-z]+\.[a-z]{2,3}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void emailCheck(BuildContext context) {
    String email = idController.text;
    if (isValidEmail(email)) {
      // mail server 설정
      String smtpEmail = "foejakzm@gmail.com";
      String password = "rxuymttufpucvlrg";

      // 메일 받을 주소
      String toEmail = email;

      // 메일 서버 설정
      final smtpServer = SmtpServer('smtp.gmail.com', 
        username: smtpEmail, 
        password: password, 
        port: 587, 
        allowInsecure: true);

      // 인증 번호 생성기
      String authenticationKey = generateRandomString(10);
      print(authenticationKey);
      sentAuthKey = authenticationKey;

      // 메일 전송
      final message = Message()
        ..from = Address(smtpEmail)
        ..recipients = [toEmail]
        ..subject = "One Day 앱 아이디 찾기 인증번호"
        ..text = "인증 번호는 [$authenticationKey] 입니다";

      // openMailApp(email, authenticationKey);

      sendMail(message, smtpServer)
      .then((_) {
        // 메일 전송 성공 시 처리
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('메일이 성공적으로 전송되었습니다.')),
        );
        setState(() {
          showAuthField = true;
        });
        
      })
      .catchError((error) {
        // 메일 전송 실패 시 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('메일 전송 중 오류가 발생했습니다: $error')),
        );
      });

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

  void validateAuthKey() {
    String inputAuthKey = authController.text;
    if (inputAuthKey == sentAuthKey) {
      // 인증키가 일치하는 경우 다음 단계로 진행
      print('인증키 일치');
      // 비밀번호 재설정 페이지로 이동 등 추가 작업 수행
    } else {
      // 인증키가 일치하지 않는 경우 에러 메시지 표시
      print('인증키 불일치');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('인증키를 다시 입력하여 주세요.')),
      );
    }
  }
  
  Future<void> sendMail(Message message, SmtpServer smtpServer) async {
    final sendReport = await send(message, smtpServer);
    print('Mail sent: ${sendReport.toString()}');
  }


// void openMailApp(String email, String authenticationKey) async {
//   final Uri emailLaunchUri = Uri(
//     scheme: 'mailto',
//     path: email,
//     query: 'subject=One Day 앱 아이디 찾기 인증번호&body=인증 번호는 [$authenticationKey] 입니다',
//   );

//   try {
//     if (await canLaunchUrl(emailLaunchUri)) {
//       await launchUrl(emailLaunchUri);
//     } else {
//       throw 'Could not launch $emailLaunchUri';
//     }
//   } catch (e) {
//     // 에러 발생 시 처리할 로직 추가
//     print('Error launching mail app: $e');
//   }
// }
  
  String generateRandomString(int length) {
    final random = Random();
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}