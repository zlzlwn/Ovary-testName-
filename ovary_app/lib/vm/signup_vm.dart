import 'package:get/get.dart';

class SignUpGetX extends GetxController{
  String email = "";
  String password1 = "";
  String password2 = "";
  String profile = "";
  String nickname = "";
  String insertdate = "";

  String selectedImagePath = "";
  

  String defaultImage = "user.png";

  

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

  
  bool idReadOnly = false;

  void updateState() {
    idReadOnly == true
    ? idReadOnly = true
    : idReadOnly = false;
    update(); // Get 패키지의 update() 메서드를 호출하여 상태를 갱신합니다.
  }
}


