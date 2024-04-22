import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';
import 'package:ovary_app/vm/signup_vm.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}
//값 사용
   MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  //중복체크 함수
  SignUpGetX signUpGetX = Get.put(SignUpGetX());
  // Gallery에서 사진 가져오기
  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  File? imgFile;

  final box = GetStorage();
class _ImageWidgetState extends State<ImageWidget> {
  MypageUpdateVM mypageUpdateVM = Get.find<MypageUpdateVM>();

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    child: Center(
                      child: imageFile == null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(mypageUpdateVM.imagepath),
                              radius: 100,
                            )
                          : Image.file(File(imageFile!.path) //null들어갈수도 있어서 ! 붙임
                              ),
                    ),
                  ),
                  Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    getImageFromDevice(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(139, 127, 245, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fixedSize: Size(MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height / 17),
                  ),
                  child: const Text(
                    'Gallery에서 사진 불러오기',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
      ],
    );
  }

  // 이미지 가져오는 함수
 getImageFromDevice(imageSource) async{
  final XFile? pickedFile = await picker.pickImage(source: imageSource);
  if(pickedFile == null){
    imageFile = null;
  }else{
    imageFile = XFile(pickedFile.path);//경로 들어온거를 이미지로 바꿔서 띄어준다
  }
  setState(() {});
}


  deleteImage(deletecode)async{
    //쿼리문 수정필요!
  // final firebaseStorage = firebaseStorage.instance.ref().child('images').child('$deletecode.png');
  // await firebaseStorage.delete();
}
}
