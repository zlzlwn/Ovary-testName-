import 'package:flutter/material.dart';

class PcosDescription extends StatelessWidget {
  const PcosDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PcosDescription',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
       
      ),
      body: Center(
        child: const Text("PcosDescription"),
      ),
    );
  }
}