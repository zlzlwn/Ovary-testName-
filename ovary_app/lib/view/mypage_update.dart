import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/widget/body/mypage_update_widget.dart';

class MypageUpdate extends StatelessWidget {
  const MypageUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MypageUpdate());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
                    '회원정보 수정',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                    ),
      ),
      body: MypageUpdateWidget(),
    );
  }
}