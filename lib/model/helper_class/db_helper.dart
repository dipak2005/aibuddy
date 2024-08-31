//
//
//
// import '../singleton_class/user_query.dart';
//
// class DBHelper {
//   static final DBHelper dbHelper = DBHelper._();
//
//   DBHelper._();
//
//   factory DBHelper() {
//     return dbHelper;
//   }
//
//   static const dbName = "aiBuddy.db";
//   static const String tableName = "query";
//
//   Database? database;
//
//   Future<Database?> checkDatabase() async {
//     if (database != null) {
//       return database;
//     } else {
//       var db = await initDB();
//       return db;
//     }
//   }
//
//   Future initDB() async {
//     database = await openDatabase(
//       dbName,
//       onCreate: (db, version) {
//         db.execute('''
//       CREATE TABLE "$tableName" (
//   "id" INTEGER PRIMARY KEY AUTOINCREMENT,
//   "user" INTEGER,
//   "text" TEXT,
//   "datetime" TEXT NOT NULL
// )''');
//       },
//       version: 1,
//       singleInstance: true,
//     );
//   }
//
//   Future<bool> insertQuery(UserQuery userQuery) async {
//     Database? db = await checkDatabase();
//     int rawEffected = await db!.insert(tableName, userQuery.toJson());
//
//     return rawEffected > 0;
//   }
//
//   Future<List<UserQuery>> getResult() async {
//     Database? database = await checkDatabase();
//
//     List<Map<String, Object?>>? result =
//     await database!.rawQuery("select * from $tableName");
//
//     return result.map((e) => UserQuery.fromJson(e)).toList() ?? [];
//   }
//
//   // Future<void> deleteQuery(UserQuery userQuery) async {
//   //   Database? db = await checkDatabase();
//   //   await db?.delete(tableName, where: "id=?", whereArgs: [userQuery.id]);
//   //   database?.close();
//   // }
// }