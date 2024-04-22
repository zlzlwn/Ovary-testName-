import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/sim_pass_insert_widget.dart';

class SimplePasswordInssert extends StatefulWidget {
  const SimplePasswordInssert({super.key});

  @override
  State<SimplePasswordInssert> createState() => _SimplePasswordInssertState();
}

class _SimplePasswordInssertState extends State<SimplePasswordInssert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('간편비밀번호 등록'),
      ),
      body: SimplePasswordWidget(),
    );
  }
}