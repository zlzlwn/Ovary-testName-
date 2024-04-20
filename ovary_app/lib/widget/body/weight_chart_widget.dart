import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovary_app/vm/vm_bmiData.dart';

class WeightChartWidget extends StatelessWidget {
  
  const WeightChartWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final VmBmiData vmBmiData = Get.put(VmBmiData());
    vmBmiData.getData();

    return Center(
      child: vmBmiData.hdata.isEmpty
      ? const CircularProgressIndicator()
      : Text('정보 가져옴'),
      
    );
  }
}