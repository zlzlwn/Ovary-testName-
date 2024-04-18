import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/signup_widget.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: SignUpWidget(),
    );
  }
}