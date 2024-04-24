
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/mypage_update.dart';
import 'package:ovary_app/view/period_Input.dart';
import 'package:ovary_app/view/sim_pass_insert.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';

class MypageMenuWidget extends StatelessWidget {
  MypageMenuWidget({super.key});
  final box = GetStorage();
  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  final mypageUpdateVMFunction = MypageUpdateVM();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(mypageUpdateVM.imagepath),
              radius: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "${mypageUpdateVM.nickname}님 환영합니다!",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const MypageUpdate());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 11),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 180, 0),
                        child: Text(
                          '회원정보 수정',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const PeriodInput());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 11),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 145, 0),
                        child: Text(
                          '생리주기 입력하기',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const SimplePasswordInssert());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 1.1,
                        MediaQuery.of(context).size.height / 11),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 145, 0),
                        child: Text(
                          '간편비밀번호 입력하기',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_sharp)
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // final databaseHandler = DatabaseHandler();
                        // await databaseHandler.clearDatabase(); // 데이터베이스 전체 삭제
                        box.remove("email"); // GetStorage에서 email 삭제
                        Get.back();
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(139, 127, 245, 1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width / 3.5,
                            MediaQuery.of(context).size.height / 17),
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showGetBottomSheet();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(MediaQuery.of(context).size.width / 3.5,
                            MediaQuery.of(context).size.height / 17),
                      ),
                      child: const Text(
                        '회원탈퇴',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showGetBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 200,
        color: Color.fromARGB(255, 196, 174, 251),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '탈퇴를 하시겠습니까?',
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 5, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        deleteUser();
                        Get.back();
                        Get.back(); 
                        Get.back();
                        box.erase();
                        guideDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(80, 40)
                      ),
                      child: const Text('탈퇴하기'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                    child: ElevatedButton(
                        onPressed: () => Get.back(), 
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(80, 40)
                        ),
                        child: const Text('취소'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  // 탈퇴처리 - deletedate에 현재날짜 update 처리
  deleteUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('user')
      .where('email', isEqualTo: box.read('email'))
      .limit(1)
      .get();

    if(querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot document = querySnapshot.docs.first;
      String documentId = document.id;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(documentId)
          .update({'deletedate' : DateTime.now()});
    } 
  }

  //탈퇴 시 안내 alert
  guideDialog() {
    Get.defaultDialog(
      title: '알림',
      middleText: '탈퇴되었습니다.',
      barrierDismissible: false,
      backgroundColor: const Color.fromARGB(255, 194, 188, 245),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            '확인',
          )
        )
      ]
    );
  }

}
