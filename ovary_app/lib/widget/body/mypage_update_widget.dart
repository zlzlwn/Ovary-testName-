import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/mypage_update.dart';
import 'package:ovary_app/vm/mypage_update_vm.dart';

class MypageUpdateWidget extends StatelessWidget {
  
  MypageUpdateWidget({super.key});

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController password1Controller = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  final MypageUpdateVM mypageUpdateVM = Get.put(MypageUpdateVM());
  
  
  // final String nicknameController = "ss";

  @override
  Widget build(BuildContext context) {
    // Get.put(MypageUpdate()); 
    return Center(
      child: GetBuilder<MypageUpdateVM>(
        builder: (controller) {
          nicknameController.text= mypageUpdateVM.nickname;
          emailController.text= mypageUpdateVM.email;
        
        return Column(
          children: [
            // Text(MypageUpdateVM.nickname),
                const CircleAvatar(
                backgroundImage: AssetImage('images/user.png'),
                radius: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: TextField(
                    controller: nicknameController,
                    decoration: const InputDecoration(
                      labelText: '닉네임들어갈 자리 (수정불가)',
                      border: OutlineInputBorder() 
                    ),
                    readOnly: true,
                    keyboardType: TextInputType.text,
                  ),
              ),
                Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: '이메일들어갈 자리 (수정불가)',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: password1Controller,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: password2Controller,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 다시 입력 하세요',
                      border: OutlineInputBorder() 
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: ElevatedButton(
                      onPressed:  () {
                        checkpassword();
                        Get.back();
                            
                        
                      }, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(139, 127, 245, 1),
                        foregroundColor: Colors.white,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width / 2,
                            MediaQuery.of(context).size.height / 17),
                      ),
                      child: const Text(
                        '정보수정',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                        ),
                    ),
             ),
          ],
        );
        },
      ),
    );
  }
checkpassword(){
  if(password1Controller.text==password2Controller.text){
    print("일치");
    
    mypageUpdateVM.password= password1Controller.text;
    
  }else{
    print("불일치");
  }
  
}
}