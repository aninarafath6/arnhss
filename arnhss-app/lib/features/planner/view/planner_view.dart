import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/planner/widgets/add_plan_bottm_form.dart';
import 'package:arnhss/features/planner/widgets/date_timline.dart';
import 'package:arnhss/features/planner/widgets/floating_button.dart';
import 'package:arnhss/features/planner/widgets/not_found.dart';
import 'package:arnhss/features/planner/widgets/planner_app_bar.dart';
import 'package:arnhss/features/planner/widgets/planner_tile/planner_tile.dart';

class PlannerView extends StatelessWidget {
  const PlannerView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    var _plans = context
        .watch<PlannerViewModel>()
        .getTasksOfTheDay(context.watch<PlannerViewModel>().selectedDate);

    return Scaffold(
      appBar: plannerAppBar(context),
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DateTimeline(),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 21.0, right: 21, top: 21),
                    child: _plans.isEmpty
                        ? const Center(child: NotFound())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                layoutBuilder: (child, _) {
                                  return child!;
                                },
                                child: PlannerTile(
                                  plan: _plans[index],
                                  key: ValueKey(_plans[index].date),
                                ),
                              );
                            },
                            itemCount: context
                                .watch<PlannerViewModel>()
                                .getTasksOfTheDay(
                                  context
                                      .watch<PlannerViewModel>()
                                      .selectedDate,
                                )
                                .length,
                          ),
                  ),
                ),
              ],
            ),
            FloatingButton(
              onTap: () => showAddPlanForm(context),
            )
          ],
        ),
      ),
    );
  }
}
