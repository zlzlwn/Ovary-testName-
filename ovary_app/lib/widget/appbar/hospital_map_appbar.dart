import 'package:flutter/material.dart';

class HospitalMapAppbar extends StatelessWidget {
  const HospitalMapAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("병원지도"),
    );
  }
   @override
  Size get PreferredSize => Size.fromHeight(kToolbarHeight);
}