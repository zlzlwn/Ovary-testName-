import 'package:flutter/material.dart';

class PcosDescriptionWidget extends StatelessWidget {
  const PcosDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
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
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '원인',
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
      
      
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '증상',
                style: TextStyle(
                  fontSize: 25,
                  backgroundColor: Colors.pink[100],
                ),
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Text(
                '다낭성 난소 증후군의 증상에는 비정상적인 월경(월경을 하지 않거나, 몇 달씩 거르거나,'
                ' 월경이 아닌 시기의 출혈 등), 고안드로젠혈증으로 인한 다모증(몸에 털이 많아지는 증상), '
                '여드름 등이 있습니다. 배란이 잘 이루어지지 않아 월경 불순이 발생하는 것이므로 '
                '불임이 될 수 있습니다. 다낭성 난소 증후군에는 비만이 많이 동반되는데, '
                '주로 허리, 둔부 비율이 증가하는 중심형 비만이 나타납니다. 당뇨병, '
                '자궁내막 증식증 또는 자궁내막암과 같은 질환의 위험성이 증가합니다.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '진단',
                style: TextStyle(
                  fontSize: 25,
                  backgroundColor: Colors.pink[100],
                ),
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Text(
                '다낭성 난소 증후군은 단일 기준으로 진단할 수 없습니다.'
                ' 희발 및 무배란, 임상적 또는 생화학적 고안드로젠혈증, '
                '초음파상 다낭성 난소의 소견이 확인되는 경우라는 세 가지 기준 중 '
                '두 가지를 만족하면서, 다낭성 난소 증후군의 다른 원인을 배제할 수 있어야 합니다. '
                '유사한 양상을 보이는 다른 질환일 가능성을 배제하기 위해서 호르몬 검사, 초음파 검사 등을 시행합니다.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '치료',
                style: TextStyle(
                  fontSize: 25,
                  backgroundColor: Colors.pink[100],
                ),
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Text(
                '임신을 원하지 않는 환자는 주기적인 호르몬 '
                '치료를 통해 규칙적인 월경을 유도합니다. 다모증, '
                '여드름이 동반된 환자는 규칙적인 월경을 목적으로 피임약을 사용합니다. '
                '임신을 원하는 환자는 배란유도제를 복용합니다. '
                '무월경이 오래 지속된 환자는 자궁내막 증식증이 있을 위험성이 높습니다. '
                '초음파 검사를 시행하여 자궁내막이 두껍다는 소견을 확인하면 조직 검사를 시행해야 합니다. '
                '무엇보다 생활 습관을 개선하고, 체중을 감량하는 것이 중요합니다. ',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '경과',
                style: TextStyle(
                  fontSize: 25,
                  backgroundColor: Colors.pink[100],
                ),
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: Text(
                '다낭성 난소 증후군으로 불임, 비만, 당뇨병, 심혈관 질환이 발생할 수 있습니다. 또한 자궁내막 증식증이 생길 수도 있습니다.'
                ' 이를 계속 방치하면 자궁내막암으로 진행할 수 있습니다.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 5),
              child: Text(
                '주의사항',
                style: TextStyle(
                  fontSize: 25,
                  backgroundColor: Colors.pink[100],
                ),
              ),
            ),
      
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 60),
              child: Text(
                '다낭성 난소 증후군으로 진단받은 경우 반드시 진료 및 치료를 받아야 합니다.'
                ' 이는 근본적으로 치료할 수 없는 질환입니다. 그렇다고 하더라도 무월경 증상을 방치할 경우'
                ' 자궁내막 증식증 및 자궁내막암의 위험성이 증가합니다. 이 질환은 비만, 당뇨병, '
                '심혈관 질환 등과의 관련성이 크며, 대사 증후군의 위험성도 높일 수 있습니다.'
                ' 따라서 다낭성 난소 증후군에 대한 주기적인 관리가 요구됩니다.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
      
      
          ],
        ),
      ),
    );
  }
}