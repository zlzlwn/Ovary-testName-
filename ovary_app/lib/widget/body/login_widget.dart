import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/users.dart';
import 'package:ovary_app/view/auth_email_view.dart';
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
                      hasEmail 
                      ? Get.to(SimpleLogIn()) 
                      : print('이메일 값이 없습니다.');
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
                      foregroundColor: Colors.white,
                      fixedSize: Size(MediaQuery.of(context).size.width / 3.5,
                            MediaQuery.of(context).size.height / 17),
                  ),
                      
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  //--- Functions ---
  loginAction(LoginGetX controller) async {
    controller.id = idController.text.trim();
    controller.password = passwordController.text.trim();

    // 1. firebase에서 id, pw값 체크하기 위함
    final loginCheck = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: controller.id)
        .where('password', isEqualTo: controller.password)
        .get();

    final loginData = await loginCheck; // Future를 해결하여 데이터를 가져옵니다.
    final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.

    // 2. 조회되는 값이 없을 때, alert창
    if (loginCheck.docs.isEmpty) {
        buttonDialog();

    //3. 회원정보가 있을 떄
    } else {           
      // ignore: unused_local_variable             
      final email = controller.id;

      // deletedate의 count값 가져오기 
      final delCheck = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: controller.id)
        .where('password', isEqualTo: controller.password)
        .where('deletedate', isEqualTo: '')
        .get()
        .then((value) => value.size);


      //deletedate가 null이 아닌 경우
      if(delCheck == 0) {
        delDialog();
      } else {
        chaekIdBoolValue(databaseHandler);  //아이디 체크하기
      }
    }
  }




  checkLogin() {
    box.write('email', idController.text);
    box.write('simpleEmail', idController.text);
  }

  //SQLite에 id값 있는지 확인
  chaekIdBoolValue(databaseHandler) async {

    int chkReult = await databaseHandler.CheckInEmail(idController.text);
    
    chkReult == 0 //id가 SQLite에 없으면 insert처리 (0 : 없음, 1 : 있음)
    ? await databaseHandler.insertUsers(Users(email: idController.text))
    : null;

    
    checkPasswordBoolValue(databaseHandler);
  }

  // pw가 있는지 체크하기
  checkPasswordBoolValue(databaseHandler) async {
    //sqlite에 간편 비밀번호 값이 있으면 home으로 이동, 없으면 simplepasswordinsert화면으로 이동!
    int result = await databaseHandler.CheckInPw(idController.text);

    //간편로그인 인증 하기 위해 storage에 email값 넣기
    checkLogin();

    //SQLite에 비밀번호가 없을 때 (result == 1)
    result == 1 
    ? guideDialog()
    : {checkLogin(), Get.to(const Home())};
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

  // 간편로그인 등록안내 알림창
  guideDialog() {
    Get.defaultDialog(
      title: '알림',
      middleText: '간편 비밀번호를 등록해주세요.',
      barrierDismissible: false,
      backgroundColor: const Color.fromARGB(255, 194, 188, 245),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.to(const SimplePasswordInssert());
          }, 
          child: const Text(
            '확인',
          )
        )
      ]
    );
  }

  // 탈퇴된 사용자 알림창
  delDialog() {
    Get.defaultDialog(
      title: '알림',
      middleText: '탈퇴한 계정입니다.',
      barrierDismissible: false,
      backgroundColor: const Color.fromARGB(255, 194, 188, 245),
      actions: [
        TextButton(
          onPressed: () {
            idController.clear();
            passwordController.clear();
            Get.back();

          }, 
          child: const Text(
            '확인',
          )
        )
      ]
    );
  }

} // End