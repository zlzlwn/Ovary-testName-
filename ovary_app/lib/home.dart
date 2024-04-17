
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(
              '영덕 대개체',
              style: TextStyle(
                fontSize: 40
              ),
            )
          ],
        ),
      ),
    );
  }
}