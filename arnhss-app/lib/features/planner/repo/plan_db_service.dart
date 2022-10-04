import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/planner/models/plan.dart';

import 'package:arnhss/services/db_service.dart';

class PlanDBService {
  final DBService _db = DBService();

  // * add new plan to local database
  Future<int> newPlan(Plan? newPlan, BuildContext context) async {
    return await _db.insert(newPlan, context);
  }

// * get all plans
  Future<List<Plan>> getTaskOfTheDay(DateTime date) async {
    return await _db.getTaskOfTheDay(date.toString());
    // return await _db.getAll();
  }
}
