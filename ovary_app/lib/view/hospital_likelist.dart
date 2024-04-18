import 'package:flutter/material.dart';
import 'package:ovary_app/widget/body/hospital_likelist_widget.dart';

class HospitalLikeList extends StatelessWidget {
  const HospitalLikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("병원 찜 목록"),
      ),
      body: HospitalLikeListWidget(),
    );
  }
}