import 'package:get/get.dart';

class SignUpGetX extends GetxController{
  String email = "";
  String password1 = "";
  String password2 = "";
  String defaultImage = "user.png";
  String profile = "";
  String nickname = "";
  String insertdate = "";

  var pwCheckResult = RxString(''); // 비밀번호 일치 여부 상태

  void passwordCheck(String password1, String password2) {
    if (password1.isEmpty || password2.isEmpty) {
      pwCheckResult.value = '숫자와 대소문자 조합으로 8자 이상 입력하여 주세요';
    } else if (password1 == password2) {
      pwCheckResult.value = '일치';
    } else {
      pwCheckResult.value = '불일치';
    }
  }

  // final idReadOnly = false.obs;

  // void setIdReadOnly(bool value) {

  //   if(value == true) {
  //     idReadOnly.value = value;
  //   }

  // }
  // var emailCheckResult = RxString(''); // 이메일 정규식

  // class SignUpController extends GetxController {
  // }
}

class SignUpController extends GetxController {
  var idReadOnly = false.obs;
  
  void setIdReadOnly(bool value) {
    idReadOnly.value = value;
  }



}

