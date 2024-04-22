import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  final MypageUpdateVM mypageUpdateVM = Get.find<MypageUpdateVM>();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: mypageUpdateVM.imagepath == "images/user.png"
          ? AssetImage(mypageUpdateVM.imagepath) as ImageProvider
          : NetworkImage(mypageUpdateVM.imagepath),
      radius: 100,
    );
  }

  // 이미지 업데이트 메서드
  void updateImage() {
    setState(() {}); // 상태를 변경하여 UI 업데이트
  }
}
