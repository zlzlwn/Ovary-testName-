import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

class MypageUpdateVM extends GetxController{
  String nickname = "";
  String email = "";
  String password1 = "";
  String password2 = "";
  String imagepath = "";

    final box = GetStorage();
 show() async {
  update();
 }

loadingUserInfoAction() async {
    print("바뀌기 전 값${imagepath}");
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: box.read('email'))
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      //firebase에서 받아온 데이터를 list로 변환
      final List<Map<String, dynamic>> dataList1 = querySnapshot.docs
          .map((doc) => {
                'email': doc['email'],
                'nickname': doc['nickname'],
                'profile': doc['profile'],
              })
          .toList();
      //받아온 list데이터를 풀어서 뷰 모델에 저장함
      email = await dataList1[0]['email'];
      nickname = await dataList1[0]['nickname'];
      imagepath = await dataList1[0]['profile'];
      


      print("-------------------------------------------");
      print("바뀐 후  값${email}");
      print("바뀐 후  값${nickname}");
      print("바뀐 후  값${imagepath}");
      update();
      //변수 바꾸고 나서 텍스트 필드에 변수 할당
     
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }


  updateAction() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: box.read('email'))
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot document = querySnapshot.docs[0]; // 첫 번째 문서 사용
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      email = data['email'];
      nickname = data['nickname'];
      imagepath = data['profile'];

      // 업데이트 작업 수행
      await FirebaseFirestore.instance
          .collection('user')
          .doc(document.id) // 문서 ID 사용
          .update({
        'email': email,
        'password': password1,
        // 프로필 필드가 있으면 업데이트
        if (imagepath != null)
          'profile': imagepath,
        // 다른 필드 업데이트
      }).then((_) {
        print("업데이트 성공");
        Get.back();
      }).catchError((error) {
        print("업데이트 실패: $error");
      });
    } else {
      // 데이터가 없는 경우
      print('데이터 없음');
    }
  }
}