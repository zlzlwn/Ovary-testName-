
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/vm/vm_snackbar.dart';
import 'package:ovary_app/widget/body/bmi_result.dart';

// ignore: must_be_immutable
class BmiQuestHeightWidget extends StatelessWidget {

  BmiQuestHeightWidget({super.key});
  
  final box = GetStorage();
  final VmSnackBar vmSnackBar = Get.put(VmSnackBar());
  int hValue = 0;

  DateTime now = DateTime.now();
  late String formattedDate;

  @override
  Widget build(BuildContext context) {

    formattedDate = now.toString().substring(0, 10); // 처음부터 10번째 문자까지 자름

    return Center(
      child: Column(
        children: [

          // 2/2 표시
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Text(
              '2/2',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),


          // 키 이미지 
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset(
              'images/height.png',
              width: 200,
            ),
          ),


          // 안내 text
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Text(
              '키를 입력하세요(cm)',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),


          //몸무게 picker
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: SizedBox(
              width: 200,
              height: 100,  //height가 있어야 이전 이후의 값들이 보인다. 
              child: CupertinoPicker(
                itemExtent: 40, 
                scrollController: FixedExtentScrollController(initialItem: 60),
                onSelectedItemChanged: (value) {
                  hValue = value+100;
                }, 
                children: List.generate(
                  101, 
                  (index) => Text(
                    (100 + index).toString()
                  )
                ),
              ),
            ),
          ),

          //버튼
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              //이전버튼
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  }, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary
                  ),
                  child: Text(
                    '이전',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ),
              ),

              //다음버튼
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    box.write('hValue', hValue);
                    insertData();
                    Get.to(BmiResult());
                  }, 
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary
                  ),
                  child: Text(
                    '다음',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  insertData() async {
    // Map<String, dynamic> myInfo = {
    //   'write' : [
    //     formattedDate,
    //     box.read('wValue'),
    //     box.read('hValue'),
    //   ]
    // };


      // //로그인한 email과 같은 user를 가져옴
      // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      //   .collection('user')
      //   .where('email', isEqualTo: box.read('email'))
      //   .limit(1)
      //   .get();

      // if(querySnapshot.docs.isNotEmpty) {
      //  // DocumentSnapshot document = querySnapshot.docs.first;
      //   //String documentId = document.id;


      //   await FirebaseFirestore.instance
      //       .collection('user')
      //       .doc(documentId)
      //       .update({'write' : myInfo['write']});
      // } 

      FirebaseFirestore.instance
      .collection('write')
      .add({
        'email' : box.read('email'),
        'height' : box.read('hValue'),
        'insertdate' : formattedDate,
        'weight' : box.read('wValue')
      });

  }
}