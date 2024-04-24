import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/findpasswd_vm.dart';

class FindPwd extends StatelessWidget {
  FindPwd({super.key});

  final TextEditingController idController = TextEditingController();
  final TextEditingController nicknameController= TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FindPwGetX findPwGetX = Get.put(FindPwGetX());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Image.asset(
                'images/OneDayLogoPurple.png',
                width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.7,
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
                          '개인 정보 입력',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: idController,
                          decoration: const InputDecoration(
                              labelText: '가입 당시 이메일을 입력하세요',
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: nicknameController,
                          decoration: const InputDecoration(
                              labelText: '닉네임을 입력하세요',
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
                            '확인',
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
    String pattern =
        r'^[a-z0-9._]+@[a-z]+\.[a-z]{2,3}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void emailCheck(BuildContext context) {
  String email = idController.text;
  if (isValidEmail(email)) {
    loginAction(FindPwGetX());
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
    nicknameController.clear();
    }
  }

  loginAction(FindPwGetX controller) async {
    controller.id = idController.text.trim();
    controller.nickname = nicknameController.text.trim();

    // 1. firebase에서 id, nickname값 체크하기 위함
    final informationCheck = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: controller.id)
        .where('nickname', isEqualTo: controller.nickname)
        // .snapshots();
        .get();

    final loginData = await informationCheck; // Future를 해결하여 데이터를 가져옵니다.
    final list = loginData.docs; // QuerySnapshot을 List로 변환합니다.
    print('dddd : $list');

    // 2. 조회되는 값이 없을 때, alert창
    if (informationCheck.docs.isEmpty) {
        buttonDialog();


    } else {                        //3. Firebase에 회원정보가 있을 떄
      final email = controller.id; // 입력한 이메일 값 가져오기
      final nickname = controller.nickname; // 입력한 이메일 값 가져오기
      print(email);
      print(nickname);

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .get();

      final List<Map<String, dynamic>> dataList1 = querySnapshot.docs
          .map((doc) => {
            'password': doc['password'],
          })
          .toList();

      controller.password = dataList1[0]['password'];
      //받아온 list데이터를 풀어서 뷰 모델에 저장함
      //vm의 변수에 할당
      // mypageUpdateVM.email = email;

      print(controller.password);
      passwordDialog(controller);

      // checkPasswordBoolValue(databaseHandler);
    }
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
          }, 
          child: const Text('확인')
        )
      ]
    );
  }

  // 비밀번호 보여주기 alert
  passwordDialog(controller) {
    Get.defaultDialog(
      title: '알림',
      middleText: '${controller.nickname}의 비밀번호는 ${controller.password}입니다',
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
            Get.back();
          }, 
          child: const Text('확인')
        )
      ]
    );
  }

} // End