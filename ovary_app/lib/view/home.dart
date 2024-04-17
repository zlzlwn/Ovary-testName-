
import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/homewidget.dart';

class Home extends StatelessWidget {
  
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: HomeWidget()
    );
  }
}