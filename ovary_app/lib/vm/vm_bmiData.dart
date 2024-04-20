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

    //user 컬렉셔에서 이메일이 로그인한 이메일인 문서 select
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    .collection('write')
    .where('email', isEqualTo: email)
    .orderBy('insertdate')
    .limit(7)
    .get();

    if(querySnapshot.docs.isNotEmpty) {
      final List<Map<String, dynamic>> dataList = querySnapshot.docs
          .map((doc) => {
            'height' : doc['height'] ,
            'weight' : doc['weight'] ,
          })
          .toList();

    // 데이터가 7개 미만인 사람일 경우는?  
    for(int i = 0; i < dataList.length; i++){
      wdata.add(dataList[i]['weight']);
      hdata.add(dataList[i]['height']);
    }


      print(wdata);
      print(hdata);

    }

    update();
  }
  
  
}