import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/hospitalmap_widget.dart';

class HospitalMap extends StatelessWidget {
  const HospitalMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("지도 페이지"),
      ),
      body: HospitalMapWidget()
    );
  }
}