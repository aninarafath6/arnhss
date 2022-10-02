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
    } else {
      try {
        String _path =
            await getDatabasesPath() + "${DatabaseConstants.planTableName}.db";
        // * open database with given columns
        _db = await openDatabase(
          _path,
          version: DatabaseConstants.version,
          onCreate: (Database db, int version) {
            debugPrint("creating a db");
            // * create a database with these columns
            return db.execute(
              "CREATE TABLE ${DatabaseConstants.planTableName}("
              "id STRING,"
              "title STRING, note STRING, date  STRING,type STRING,"
              "remind  STRING,subject STRING,isComplete STRING)",
            );
          },
        );
        // debugPrint(_db.toString());
      } catch (e) {
        // * handle error with handle exception
        debugPrint(e.toString());
        HandleException().handleException(e);
      }
    }
  }

  Future<int> insert(Plan? plan, BuildContext context) async {
    debugPrint("insert new plan");
    // var res =
    //     await _db?.insert(DatabaseConstants.planTableName, plan!.toMap()) ?? 1;
    debugPrint(await _db
        ?.insert(DatabaseConstants.planTableName, plan!.toMap(context))
        .toString());
    return 1;
  }
}
