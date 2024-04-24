import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/bmi_model.dart';
import 'package:ovary_app/widget/appbar/bmi_quest_weight.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeightChartWidget extends StatefulWidget {
  const WeightChartWidget({Key? key}) : super(key: key);

  @override
  _WeightChartWidgetState createState() => _WeightChartWidgetState();
}

class _WeightChartWidgetState extends State<WeightChartWidget> {
  final box = GetStorage();
  List hData = [];
  List wData = [];
  List dData = [];

  List bData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: dData.isNotEmpty
          ? Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Text('나의 체중과 BMI 변화를 보여드립니다. (7일간)'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: SizedBox(
                    width: 380,
                    height: 400,
                    child: SfCartesianChart(
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: [
                        ColumnSeries<BmiModel, dynamic>(
                          dataSource: List.generate(
                            dData.length,
                            (index) => BmiModel(
                              date: dData[index],
                              weight: wData[index],
                              height: hData[index],
                            ),
                          ),
                          color: Colors.green[300],
                          xValueMapper: (BmiModel model, _) => model.date,
                          yValueMapper: (BmiModel model, _) => model.weight,
                          name: '몸무게(kg)',
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                        ),
                        LineSeries<BmiModel, dynamic>(
                          dataSource: List.generate(
                            dData.length,
                            (index) => BmiModel(
                              date: dData[index],
                              weight: wData[index],
                              height: hData[index],
                            ),
                          ),
                          color: Colors.red,
                          xValueMapper: (BmiModel model, _) => model.date,
                          yValueMapper: (BmiModel model, _) => double.parse((model.weight / ((model.height*0.01)* (model.height*0.01))).toStringAsFixed(1)),
                          name: 'BMI',
                          dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                        ),
                      ],
                      primaryXAxis: const CategoryAxis(
                        title: AxisTitle(text: '날짜'),
                      ),
                      primaryYAxis: const NumericAxis(
                        title: AxisTitle(text: '몸무게, BMI'),
                      ),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.to(const BmiQuestWeight());
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300]
                  ),
                  child: const Text(
                    'BMI 등록하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('등록된 BMI가 없습니다.'),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.to(const BmiQuestWeight());
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300]
                  ),
                  child: const Text(
                    'BMI 등록하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }

  //firebase에서 데이터 가져오기
  getData({String? tags}) async {
    String email = box.read('email');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('write')
        .where('email', isEqualTo: email)
        .orderBy('insertdate', descending: true) //내림차순
        .limit(7)
        .get();

      if (querySnapshot.docs.isNotEmpty) {
        final List<Map<String, dynamic>> dataList = querySnapshot.docs
            .map((doc) => {
                  'height': doc['height'],
                  'weight': doc['weight'],
                  'date': doc['insertdate'],
                })
            .toList();

        for (int i = 0; i < dataList.length; i++) {
          wData.add(dataList[i]['weight']);
          hData.add(dataList[i]['height']);
          dData.add(dataList[i]['date']);
        }
      }

      setState(() {}); // 데이터가 업데이트 되었음을 알려줌
  }
}

