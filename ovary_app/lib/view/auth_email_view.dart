import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/auth_email.dart';

class FindPassword extends StatelessWidget {
  const FindPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('본인 인증')
      ),
      body: const AuthEmail(),
    );
  }
}