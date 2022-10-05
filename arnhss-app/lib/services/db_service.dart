import 'package:arnhss/common/constants/database_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/planner/models/plan.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:sqflite/sqflite.dart';

class DBService with HandleException {
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
      } catch (e) {
        // * handle error with handle exception
        debugPrint(e.toString());
        HandleException().handleException(e);
      }
    }
  }

// * insert data to local sqlite database
  Future<int> insert(dynamic payload, BuildContext context) async {
    debugPrint("insert new plan");
    // * add a plan and return row Index
    return await _db?.insert(
            DatabaseConstants.planTableName, payload!.toRawMap(context)) ??
        1;
  }

  // * get all data
  Future<List<Plan>> getAll() async {
    late final List<Plan>? result;
    try {
      // * get all plans from sqlite database
      result = await _db
          ?.rawQuery("SELECT * FROM ${DatabaseConstants.planTableName}")
          .then(
            (value) => Plan.listFromJson(value),
          );
    } catch (e) {
      handleException(e);
    }

    return result!;
  }

// * get task of the day
  Future<List<Plan>> getTaskOfTheDay(String date) async {
    late final List<Plan>? result;

    try {
      // * fetching plans from db by using date
      result = await _db?.query(DatabaseConstants.planTableName,
          where: "date=?", whereArgs: [date]).then(
        (value) => Plan.listFromJson(value),
      );
    } catch (e) {
      // ? if there is any exception if will handle handle exception
      handleException(e);
    }

    return result!;
  }

  Future<void> removePlan(String id) async {
    try {
      await _db?.delete(DatabaseConstants.planTableName,
          where: "id=?", whereArgs: [id]);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> removeAll() async {
    try {
      await _db?.rawDelete("DELETE  FROM ${DatabaseConstants.planTableName}");
    } catch (e) {
      handleException(e);
    }
  }
}
