import 'package:flutter/material.dart';

class PcosTitle extends StatelessWidget {
  const PcosTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'PCOS 설문',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
    );
  }
}