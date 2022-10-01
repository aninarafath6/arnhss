import 'package:arnhss/common/constants/database_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/planner/models/plan.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  static Database? _db;

  static Future<void> initDB() async {
    // ? if db is created then just return
    if (_db != null) {
      debugPrint("db is already created");
      return;
    }

    try {
      String _path = await getDatabasesPath() + "plan.db";
      _db = await openDatabase(
        _path,
        version: DatabaseConstants.version,
        onCreate: (Database db, int version) {
          debugPrint("creating a db");

          // * create a database with these columns
          return db.execute(
            "CREATE TABLE ${DatabaseConstants.planTableName}("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT, date  STRING,"
            "remind  STRING,subject STRING,isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      // * handle error with handle exception
      debugPrint(e.toString());
      HandleException().handleException(e);
    }
  }

  Future<int> insert(Plan? plan) async {
    debugPrint("insert new plan");
    return await _db?.insert(DatabaseConstants.planTableName, plan!.toMap()) ??
        1;
  }
}
