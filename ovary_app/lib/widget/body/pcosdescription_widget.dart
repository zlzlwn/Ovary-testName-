import 'package:flutter/material.dart';

class PcosDescriptionWidget extends StatelessWidget {
  const PcosDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Text(
              '시상하부-뇌하수체-난소의 호르몬 이상으로 난소의 남성 호르몬 분비가'
              '증가하여 배란이 잘 이루어지지 않아 월경 불순, 다모증, 비만, 불임이 발생하고'
              '장기적으로 대사 증후군과 연관되는 질환을 의미힙니다.'
              '이 질환에는 인슐린 저항성 또는 고인슐린혈증이 동반될 수 있습니다.',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              '다낭성 난소 증후군의 원인',
              style: TextStyle(
                fontSize: 25,
                backgroundColor: Colors.pink[100],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
            child: Text(
              '다낭성 난소 증후군의 원인은 정확하게 밝혀지지 않았습니다.'
              '어떤 원인에 의한 것이든 인슐린 저항성, 안드로젠호르몬(남성호르몬) 과다혈증, '
              '비정상적인 호르몬의 분비 등이 발생하여 생기는 내분비 질환입니다.',
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),


        ],
      ),
    );
  }
}