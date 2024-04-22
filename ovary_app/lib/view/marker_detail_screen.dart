import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MarkerDetailScreen extends StatelessWidget {
  const MarkerDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marker Detail'),
      ),
      body: Center(
        child: Text('Marker detail screen'),
      ),
    );
  }
}