import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/view/hospital_map.dart';
import 'package:ovary_app/view/pcosdescription.dart';
import 'package:ovary_app/view/period_calendar.dart';
import 'package:ovary_app/widget/appbar/bmi_quest_weight.dart';
import 'package:ovary_app/widget/appbar/work_video.dart';
import 'package:ovary_app/widget/body/pcos_survey_weight.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          //pcos버튼
          IconButton(
            onPressed: () {
              Get.to(const PcosDescription());
            },
            icon: ClipRRect(
              borderRadius:
                  BorderRadius.circular(5), //---------------왜 사진이 안깍이는지 확인필요
              child: Image.asset(
                "images/pcosbutton.png",
                width: MediaQuery.of(context).size.width / 1.3,
                height: MediaQuery.of(context).size.height / 4,
                // 높이 조절
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(PcosSurveyWeight());
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 215, 222, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 6
                     ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          'PCOS 예측',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Image.asset(
                          "images/hospital.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const PeriodCalender());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 215, 222, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fixedSize: Size( MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 6
                     ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            '나의 생리주기',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Image.asset(
                            "images/hospital.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                     Get.to(const BmiQuestWeight());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 215, 222, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 6
                     ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '나의 BMI는?',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Image.asset(
                          "images/hospital.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {

                    Get.to(const WorkVideo());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 215, 222, 1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fixedSize: Size( MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 6
                     ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text(
                          '추천운동',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Image.asset(
                          "images/hospital.png",
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const HospitalMap());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(255, 215, 222, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fixedSize: Size( MediaQuery.of(context).size.width / 4,
                      MediaQuery.of(context).size.height / 6
                     ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            '병원찾기',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Image.asset(
                            "images/hospital.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
