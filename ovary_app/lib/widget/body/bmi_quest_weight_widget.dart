import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/widget/appbar/bmi_quest_height.dart';

// ignore: must_be_immutable
class BmiQuestWeightWidget extends StatelessWidget {


  BmiQuestWeightWidget({super.key});
  
  final box = GetStorage();

  int wValue = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [

          // 1/2 표시
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Text(
              '1/2',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ),


          // 체중계 이미지 
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset(
              'images/weight.png',
              width: 200,
            ),
          ),


          // 안내 text
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Text(
              '몸무게를 입력하세요(kg)',
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
                itemExtent: 30, 
                scrollController: FixedExtentScrollController(initialItem: 30),
                onSelectedItemChanged: (value) {
                  wValue = value+30;
                }, 
                children: List.generate(
                  81, 
                  (index) => Text(
                    (30 + index).toString()
                  )
                ),
              ),
            ),
          ),

          //다음 버튼
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: ElevatedButton(
              onPressed: () {
                box.write('wValue', wValue);
                Get.to(const BmiQuestHeight());
              }, 
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120, 50),
                backgroundColor: const Color(0xff8b7ff5)
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
      ),
    );
  }
}