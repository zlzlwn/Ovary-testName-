
import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/mypage_menu_widget.dart';

class MypageMenu extends StatelessWidget {
  const MypageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("마이페이지"),
      ),
      body: MypageMenuWidget(),
    );
  }
}