import 'package:get_storage/get_storage.dart';
import 'package:ovary_app/model/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  final box = GetStorage();
  Future<Database> initializeDB() async {
    //db를 어디위치
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user.db'),
      onCreate: (db, version) async {
        //테이블 만들기(초기 구동시에만 작동)
        await db.execute(
            "create table users (id integer primary key autoincrement, email text,password text)");
      },
      version: 1,
    );
  }

//검색
  Future<List<Users>> queryUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults =
        await db.rawQuery('select * from users');
    return queryResults.map((e) => Users.fromMap(e)).toList();
  }

  //이메일 입력-----@@@@@@@@
  Future<void> insertUsers(Users user ) async {
    final Database db = await initializeDB();
    await db.rawInsert('insert into users(email) values (?)', [user.email]);
  }

  //간편비밀번호 값 입력
  Future<int> updateUserPassword(String email, String newPassword) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
        'UPDATE users SET password = ? WHERE email = ?', [newPassword, email]);
    return result;
  }

//아이디값 찾아서 비빌번호 뱉어내주는 함수
  Future<String?> getUserPassword(String email) async {
    final db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['password'],
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first['password'];
    }

    return null;
  }

  //로그인할때 db에 email 데이터가 있는지 없는지 확인하는 함수-> 로그인 페이지 간편 로그인 시에 활용!
  Future<bool> hasEmailData() async {
    final db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['email'],
      where: 'email IS NOT NULL',
      limit: 1, //
    );

    return maps.isNotEmpty;
  }

//로그아웃시에 db에 있는 데이터를 다 삭제함-> 필요없음
  Future<void> clearDatabase() async {
    final db = await initializeDB();
    await db.execute('DELETE FROM users');
  }

//로그인시 db의 password 컬럼에  null값이 있는지 확인하는 함수 ->로그인시 간편비밀번호 등록에 사용!@@@@
  Future<int> hasPassword() async {
    final db = await initializeDB();
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      columns: ['password'],
      where: 'password IS NOT NULL',
      limit: 1,
    );

    return maps.isNotEmpty ? 1 : 0; // password 값이 null이 아니면 1, null이면 0
  }


//사용자가 입력한 이메일이 Sqlite에 이메일이 있는지 체크
  Future<int> CheckInEmail(String email) async {
    int result = 0;
    final db = await initializeDB();

    result = Sqflite.firstIntValue(
      await db.rawQuery('select count(email) from users where email = ?', [email])
    )!;

    return result; //이메일이 있으면 1, 없으면 0
  }


//사용자가 입력한 이메일 Sqlite에 pw 체크
  Future<int> CheckInPw(String email) async {
    int result = 0;
    final db = await initializeDB();

    result = Sqflite.firstIntValue(
      //select count(email) from likes where email = 'nara@naver.com' and initdate is null;
      await db.rawQuery('select count(email) from users where email = ? and password is null', [email])
    )!;

    return result; //비밀번호가 없으면 1, 있으면 0
  }

}
