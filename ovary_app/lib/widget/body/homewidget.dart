import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:ovary_app/view/hospital_map.dart';
import 'package:ovary_app/view/login.dart';
import 'package:ovary_app/view/pcosdescription.dart';
import 'package:ovary_app/view/period_Input.dart';
import 'package:ovary_app/widget/appbar/bmi_quest_weight.dart';
import 'package:ovary_app/widget/appbar/work_video.dart';
import 'package:ovary_app/widget/body/pcos_survey_weight.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
    final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //pcos버튼
        Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: IconButton(
          onPressed: () {
            Get.to(const PcosDescription());
          },
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(13), 
            child: Image.asset(
              "images/pcosbutton.png",
              width: MediaQuery.of(context).size.width / 1.0,
              height: MediaQuery.of(context).size.height / 4,
              fit: BoxFit.cover, 
            ),
          ),
        ),
      ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Get.to(const PcosSurveyWeight());
                    print(box.read('email'));
                    box.read('email')==null
                    ? loginDialog(context)
                    :  Get.to(const PcosSurveyWeight());
                   
                    
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                      foregroundColor: const Color.fromRGBO(139, 127, 245, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 3.5,
                      MediaQuery.of(context).size.height / 5.1
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          children: [
                            Text(
                              'PCOS 예측',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Image.asset(
                          "images/survey.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Get.to(const PeriodInput());
                      print(box.read('email'));
                       box.read('email')==null
                    ? loginDialog(context)
                    :  Get.to(const PeriodInput());
                      
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 215, 222, 1),
                      foregroundColor: const Color.fromRGBO(225, 105, 125, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 3.5,
                      MediaQuery.of(context).size.height / 5.1
                      ),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            '나의 생리주기',
                            style: TextStyle(
                                fontSize: 15.5, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Image.asset(
                            "images/calendarr.png",
                            width: 300,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(const BmiQuestWeight());
                      box.read('email')==null
                    ? loginDialog(context)
                    :  Get.to(const BmiQuestWeight());
                    
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                      foregroundColor: const Color.fromRGBO(139, 127, 245, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 3.5,
                      MediaQuery.of(context).size.height / 5.1
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '나의 BMI는?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Image.asset(
                          "images/bmii.png",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ElevatedButton(
                      onPressed: () {
                       Get.to(const WorkVideo());
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(245, 241, 255, 1),
                        foregroundColor: const Color.fromRGBO(139, 127, 245, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                      fixedSize: Size( MediaQuery.of(context).size.width / 3.5,
                        MediaQuery.of(context).size.height / 5.1
                        ),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              '추천운동',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.asset(
                              "images/workout.png",
                              width: 130,
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                         box.read('email')==null
                    ? loginDialog(context)
                    :  Get.to(const HospitalMap());
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(255, 215, 222, 1),
                        foregroundColor: const Color.fromRGBO(225, 105, 125, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 3.5,
                      MediaQuery.of(context).size.height / 5.1
                        ),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              '병원찾기',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Image.asset(
                              "images/hospital.png",
                              width: 100,
                              height: 100,
                              
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
              ],
            ),
          ),
        ],
      ),
    );
  }
  loginDialog(context){
    print(box.read('email'));
    
    showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      content: Text(
        '로그인이 필요한 서비스입니다.',
        style: TextStyle(
          color: Colors.black, 
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            Get.to(LogIn());
          },
          child: Text(
            '확인',
            style: TextStyle(
              
            ),
          ),
        ),
      ],
    );
  },
);

  }
}