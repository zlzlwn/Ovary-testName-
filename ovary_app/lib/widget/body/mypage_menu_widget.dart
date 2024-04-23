import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/view/mypage_update.dart';
import 'package:ovary_app/view/period_Input.dart';
import 'package:ovary_app/view/sim_pass_insert.dart';
import 'package:ovary_app/vm/database_handler.dart';
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
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
                ),
             ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(MypageUpdate());
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
                          '회원번호 수정',
                          style: TextStyle(fontSize: 22),
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
                    Get.to(PeriodInput());
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
                          style: TextStyle(fontSize: 22),
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
                    Get.to(SimplePasswordInssert());
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
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
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
    fixedSize: Size(MediaQuery.of(context).size.width / 3.5, MediaQuery.of(context).size.height / 17),
  ),
  child: const Text(
    '로그아웃',
    style: TextStyle(
      fontWeight: FontWeight.bold,
    ),
  ),
),
                ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: ElevatedButton(
                  onPressed:  () {
                    
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(139, 127, 245, 1),
                    foregroundColor: Colors.white,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width / 3.5,
                        MediaQuery.of(context).size.height / 17),
                  ),
                  child: const Text(
                    '회원탈퇴',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
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
}
