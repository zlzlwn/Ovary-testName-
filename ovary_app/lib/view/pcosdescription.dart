import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/pcosdescription_widget.dart';

class PcosDescription extends StatelessWidget {
  const PcosDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PCOS란?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
       
      ),
      body: PcosDescriptionWidget()
    );
  }
}