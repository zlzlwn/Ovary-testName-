import 'package:flutter/material.dart';

class PcosDescriptionWidget extends StatelessWidget {
  const PcosDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green, 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '다낭성난소증후군(PCOS)이란?', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군(PCOS)은 난소에서 남성 호르몬인 안드로겐이 지나치게 많이 분비되면서 발생하는 이상 현상입니다. 남성호르몬인 안드로겐은 여성의 몸에도 소량 존재합니다.', 
                    style: TextStyle(
                      color: Color(0xFFFFA600),
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '말 그대로, 다낭성(Polycystic)은 액체로 가득찬 수십 개의 작은 낭종을 의미하며 난소에서 생성됩니다. 이 낭종들은 몸에 나쁜 것으로 간주됩니다. 하지만 그것은 그저 난자를 가지고 있는 아주 작은 난포일뿐입니다. 난포는 초기 단계에서 성장을 멈추고 배란이 되지 못하게 합니다. 일반적인 상황에서는 난포가 성장해 배란이 이뤄집니다. 난자가 수정이 이뤄지는 과정이죠.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군은 난임의 원인이기도 합니다. 다낭성난소증후군이 있는 여성은 배란을 하기 위한 호르몬을 충분히 가지고 있지 못합니다. 이 때문에 배란이 적절히 이뤄지지 않고 결과적으로 난소에 수많은 낭종이 생깁니다. 이때 낭종은 안드로겐이라는 남성 호르몬을 더 많이 생산합니다. 상대적으로 프로게스테론은 정상 수치보다 낮아집니다. 결과적으로 다낭성난소증후군을 앓고 있는 여성은 안드로겐 호르몬 수치가 높습니다. 이러한 호르몬 불균형이 생리 주기를 불규칙하게 하고 임신을 어렵게 만듭니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '연구에 따르면, 가임기 여성(15세~44세)의 2.2%에서 최대 26.7%가 다낭성난소증후군을 앓고 있었습니다. 하지만 여성의 70%는 다낭성난소증후군을 진단 받지 못했습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '어려운 점은 다낭성난소증후군은 형태와 심각도가 사람마다 다르다는 것입니다. 어떤 환자들은 매우 가볍고 안정된 형태의 다낭성난소증후군을 가지고 있지만 어떤 환자는 매우 심각한 증상을 가지고 있습니다. 높아진 안드르겐 수치 또는 인슐린 저항성과 다낭성난소증후군이 항상 관련이 있는 것도 아닙니다. 하지만 일반적으로 이러한 요소가 다낭성난소증후군과 관련이 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'images/PCOS01.webp',
                    width: 300,
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green, 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '다낭성난소증후군의 원인', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군의 정확한 원인은 밝혀지지 않았습니다. 하지만, 다낭성난소증후군을 앓는 여성에게서 인슐린 저항성이 발견했습니다. 인슐린은 췌장에서 생산하는 호르몬으로 음식물에서 당을 분리해 신체의 에너지로 사용하는 역할을 합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군을 앓고 있는 여성도 인슐린을 생산하지만 효과적으로 사용할 수 없습니다. 또, 여분의 인슐린이 난소를 자극해 더 많은 남성호르몬, 안드로겐을 생산하도록 합니다. 이것이 여성의 생리 불순, 여드름, 탈모를 일으키며 얼굴과 몸에 털을 자라게 합니다. 높은 인슐린 수치는 겨드랑이와 목 주변 피부를 검게 만들기도 합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '유전자도 다낭성난소증후군을 일으키는 핵심 역할을 합니다. 왜냐하면 다낭성난소증후군을 가진 여성의 경우, 어머니 또는 자매가 이러한 문제를 가지고 있을 가능성이 높습니다. 하지만 다낭성난소증후군의 원인을 파악하기 위해서는 더 많은 연구가 필요합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                // Image.asset(
                //   'images/PCOS02.webp',
                //   width: 300,
                // ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green, 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '다낭성난소증후군의 증상', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '몇몇 여성은 생리를 처음 시작할 때, 다낭성난소증후군의 증상을 경험합니다. 또 다른 여성의 경우, 체중 증가나 난임을 겪고 난 뒤 이 증후군이 있다는 것을 알게 됩니다. 보통 다낭성난소증후군은 아래 3가지 증상 중 2가지 증상이 있을 때 의심할 수 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '생리 불규칙입니다. 다낭성난소증후군의 전형적인 증상이 생리 불규칙입니다. 대게 일년 동안 9번 생리를 하거나 아예 하지 않는 경우가 있습니다. 다낭성난소증후군이 약하게 있는 여성은 생리주기가 조금 길어지기도 합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성 난소. 여성의 난소가 확장되고 난포 수천 개가 난자를 둘러싸게 됩니다. 그 결과, 난소가 규칙적인 세포 활동을 하지 못하게 됩니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '안드로겐 분비 과다. 남성 호르몬인 안드로겐 분비가 많아지면 신체적인 변화를 일으킵니다. 얼굴과 등, 배, 가슴에 털이 많이 자랍니다. 여드름이나 남성형 탈모가 진행됩니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '기타 증상', 
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 체중 증가.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '안드로겐 분비 과다. 남성 호르몬인 안드로겐 분비가 많아지면 신체적인 변화를 일으킵니다. 얼굴과 등, 배, 가슴에 털이 많이 자랍니다. 여드름이나 남성형 탈모가 진행됩니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 피부가 거뭇해지는 증상.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '목 뒤나 가슴, 팔, 사타구니 아래 피부가 검게 변합니다.                        ', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 여드름.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군은 등과 가슴, 얼굴에 여드름을 만듭니다. 이 증상은 10대가 지나도 계속되며 치료하기가 어렵습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 두통.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '호르몬 변화는 두통을 유발합니다.                                               ', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 골반 통증.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '생리주기 동안 심각한 출혈과 함께 골반 통증이 생깁니다. 피가 나오지 않더라도 골반 통증이 발생하기도 합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 수면 장애.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군은 수면무호흡증으로 이어집니다. 몇몇 여성은 수면 중 짧은 시간 동안 숨을 멈춥니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 피곤.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '질 낮은 수면은 만성 피로감을 느낍니다.                                      ', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 기분 변화.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군은 기분 변화와 우울증, 불안함 등을 증가시킵니다.                                   ', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 심한 출혈.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '오랜 시간 동안 자궁 내벽이 만들어집니다. 이 때문에 생리가 시작하면 일반적인 양보다 더 많을 수 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 머리 숱 감소.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군을 앓으면 머리 숱이 감소합니다. 남성형 탈모가 진행됩니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      '- 난임.', 
                      style: TextStyle(
                        color: Color(0xFFFFA600),
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군은 여성 난임의 대표적인 원인입니다. 배란 횟수가 줄어들면 자연스럽게 임신 가능성이 낮아집니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green, 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '다낭성난소증후군 진단', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '담당 난임 산부인과 전문의는 환자의 병력과 증상, 가족의 병력 등을 묻습니다. 이어, 신체 변화를 확인합니다. 머리숱과 여드름, 피부색을 검사합니다. 또, 난소가 커져 있는지, 자궁 안에 다른 것들이 커져 있지 않은지 알아보기 위해 질과 자궁 등을 검사합니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '환자들은 피검사와 초음파 검사를 해야합니다. 신체 내 낭종과 자궁 내벽의 두께 등을 확인하기 위해서입니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.green, 
                    borderRadius: BorderRadius.circular(10), 
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '다낭성난소증후군 치료', 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '다낭성난소증후군 치료는 여러가지 요소에 의해 정해집니다. 나이, 자궁과 질의 건강 등이 고려 대상입니다. 대게 약물로 관리됩니다. 약이 다낭성난소증후군을 직접 치료할 수는 없지만, 통증을 완화하고 기타 건강 문제를 개선할 수 있습니다. 임신할 계획이라면 다음을 참고하세요.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- 식습관을 바꿔 체중을 줄이세요. 한 연구에 따르면, 체중을 약 10% 줄이면, 생리 주기가 더 규칙적으로 변하고 다낭성난소증후군의 증상을 완화합니다. 인슐린 수치를 낮춰 당뇨와 심장병 위험을 낮춥니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- 운동. 운동은 환자의 체중을 줄이고 당뇨나 심장병 위험을 낮춥니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- 약은 배란을 규칙적으로 하는데 도움을 줍니다. 하지만 다태아 출산 가능성을 높이고 난소를 지나치게 자극하는 부작용이 있을 수 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- 시험관아기시술(IVF). 환자의 난자를 연구실에서 배우자의 정자와 수정해 자궁으로 옮기는 시술입니다. 약물로도 배란이 어려울 경우, 이 시술을 선택할 수 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '임신할 계획이 없다면 다음을 참고하세요.                                   ', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '- 피임약이 안드로겐 수치를 낮추는데 도움을 주고 생리주기도 통제합니다. 또, 자궁내벽에 비이상적으로 크는 세포를 막을 수 있습니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '-약은 여러가지 증상을 완화합니다. 메트포민(Metformin)은 높아진 인슐린 수치를 낮추는데 기여합니다. 클로미드(Clomid)와 레트로졸(Letrozole)은 배란을 촉진하는 데 쓰는 가장 보편적인 약입니다.', 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}