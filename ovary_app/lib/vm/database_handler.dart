import 'package:ovary_app/model/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    //db를 어디위치
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'user.db'),
      onCreate: (db, version) async {
        //테이블 만들기(초기 구동시에만 작동
        await db.execute(
            "create table users (id integer primary key autoincrement, email text)");
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

  //입력
  // return 받기 싫으면 <void>를 쓰면 된다
  Future<int> insertUsers(Users user) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into users(email) values (?)',
      [user.email]
    );
    return result;
  }

  
}


