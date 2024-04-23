import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/findpw.dart';

class FindPw extends StatelessWidget {
  const FindPw({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('비밀번호 찾기')
      ),
      body: const FindPwd(),
    );
  }
}