// ERD에서 Firebase에서 write relation 부분 
class Write {

  String email;         //이메일
  DateTime insertdate;  //입력날짜
  int weight;           //몸무게
  int height;           //키

  Write({
    required this.email,
    required this.insertdate,
    required this.weight,
    required this.height,
  }); 
}