import 'package:flutter/material.dart';

class MypageMenuWidget extends StatelessWidget {
  const MypageMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
            backgroundImage: AssetImage('images/user.png'),
            radius: 100,
          ),
            Text("사진들어갈자리"),
            
          ],
          
        ),
      ),
    );
  }
}