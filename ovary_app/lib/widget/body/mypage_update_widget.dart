import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/mypage_menu.dart';

class MypageUpdateWidget extends StatelessWidget {
  const MypageUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
              const CircleAvatar(
              backgroundImage: AssetImage('images/user.png'),
              radius: 100,
            ),
            ElevatedButton(
                  onPressed: () {
                    Get.to(MypageMenu());
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
        ],
      ),
    );
  }
}