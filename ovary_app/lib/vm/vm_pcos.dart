import 'package:flutter/material.dart';

class ChangeWeightSwitch extends StatelessWidget with ChangeNotifier{
  ChangeWeightSwitch({super.key});

  bool weightValue = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '아니요',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Switch(
              value: weightValue, 
              onChanged: (value) {
                weightValue = value;
                notifyListeners();
                // ******************************/  value 값 처리하기
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '네',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}