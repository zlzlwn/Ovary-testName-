import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/bmi_model.dart';
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: dData.isNotEmpty
          ? SizedBox(
              width: 380,
              height: 400,
              child: SfCartesianChart(
                legend: const Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: [
                  LineSeries<BmiModel, dynamic>(
                    dataSource: List.generate(
                      dData.length,
                      (index) => BmiModel(
                        date: dData[index],
                        weight: wData[index],
                        height: hData[index],
                      ),
                    ),
                    color: Colors.red[300],
                    xValueMapper: (BmiModel model, _) => model.date,
                    yValueMapper: (BmiModel model, _) => model.weight,
                    dataLabelSettings:
                    const DataLabelSettings(isVisible: true),
                  )
                ],
                primaryXAxis: const CategoryAxis(
                  title: AxisTitle(text: '날짜'),
                ),
                primaryYAxis: const NumericAxis(
                  title: AxisTitle(text: '몸무게'),
                ),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }

  //firebase에서 데이터 가져오기
  getData() async {
    String email = box.read('email');

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('write')
        .where('email', isEqualTo: email)
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
      setState(() {}); // 데이터가 업데이트 되었음을 알려줌
    }
  }
}

