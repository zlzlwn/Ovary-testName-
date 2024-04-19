import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VmBmiData extends GetxController {

  var box = GetStorage();
  List hdata = [];
  List wdata = [];


  getData() async {

    //로그인한 email 
    String email = box.read('email');

    //Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //user 컬렉셔에서 이메일이 로그인한 이메일인 문서 select
    QuerySnapshot querySnapshot = await firestore
    .collection('user')
    .where('email', isEqualTo: email)
    .get();

    for(QueryDocumentSnapshot doc in querySnapshot.docs) {
      print(doc.data());
    }

    update();
  }
  
  
}