import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/planner/widgets/add_plan_bottom_form.dart';
import 'package:arnhss/features/planner/widgets/date_timeline.dart';
import 'package:arnhss/features/planner/widgets/floating_button.dart';
import 'package:arnhss/features/planner/widgets/not_found.dart';
import 'package:arnhss/features/planner/widgets/planner_app_bar.dart';
import 'package:arnhss/features/planner/widgets/planner_tile.dart';

class PlannerView extends StatelessWidget {
  const PlannerView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  Widget build(BuildContext context) {
    // var _plans = ;

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
                    child: FutureBuilder<List<PlannerModel>>(
                      future: context
                          .watch<PlannerViewModel>()
                          .getTasksOfTheDay(
                              context.watch<PlannerViewModel>().selectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  9, (index) => const PlanSkelton()),
                            ),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(child: NotFound());
                        }

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              layoutBuilder: (child, _) {
                                return child!;
                              },
                              child: PlannerTile(
                                plan: snapshot.data![index],
                                key: ValueKey(snapshot.data![index].date),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        );
                      },
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
