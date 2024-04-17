import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:ovary_app/vm/bmiQuest.dart';
import 'package:ovary_app/widget/appbar/bmi_quest_weight.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'yd',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BmiQuestProvider(),
          ),
        ],
        child: const BmiQuestWeight(),
      ),
    );
  }
}
