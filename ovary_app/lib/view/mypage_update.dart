import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/mypage_update_widget.dart';

class MypageUpdate extends StatelessWidget {
  const MypageUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("정보수정"),
      ),
      body: MypageUpdateWidget(),
    );
  }
}