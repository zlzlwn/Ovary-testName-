import 'package:flutter/material.dart';
import 'package:ovary_app/widget/appbar/hospital_map_appbar.dart';

class HospitalMap extends StatelessWidget {
  const HospitalMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HospitalMapAppbar(),
      body: Center(
        child: Text("지도 페이지"),
      ),
    );
  }
}