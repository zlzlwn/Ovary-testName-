
class Users{
  //db구성이 제일 먼저임!
  int? id;//key값 들어갈때는 값이 없어서 ? 붙임
  String email;
  

  //생성자
  Users({
      this.id,
      required this.email,
  });
//ver3 factory: point를 map 형식으로 바꿔준다! (생성되면서 매소드도 실행시킨다?) r검색시에 사용
Users.fromMap(Map<String, dynamic> res)  
    :id= res['id'],
    email= res['email'];
  




}