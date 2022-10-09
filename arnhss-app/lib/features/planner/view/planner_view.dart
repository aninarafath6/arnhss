import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/planner/widgets/add_plan_bottom_form.dart';
import 'package:arnhss/features/planner/widgets/date_timeline.dart';
import 'package:arnhss/features/planner/widgets/floating_button.dart';
import 'package:arnhss/features/planner/widgets/not_found.dart';
import 'package:arnhss/features/planner/widgets/planner_app_bar.dart';
import 'package:arnhss/features/planner/widgets/planner_tile.dart';

class PlannerView extends StatefulWidget {
  const PlannerView({Key? key}) : super(key: key);
  static const routeName = '/task_view';

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  @override
  void initState() {
    // * get task of the day when widget's first build
    context
        .read<PlannerViewModel>()
        .getTasksOfTheDay(context.read<PlannerViewModel>().selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Planner build");

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
                    child: context.watch<PlannerViewModel>().planCount == 0
                        ? const Center(child: NotFound())
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                layoutBuilder: (child, _) {
                                  return child!;
                                },
                                child: PlannerTile(
                                  plan: context
                                      .watch<PlannerViewModel>()
                                      .plans[index],
                                  key: ValueKey(context
                                      .watch<PlannerViewModel>()
                                      .plans[index]
                                      .id),
                                ),
                              );
                            },
                            itemCount:
                                context.watch<PlannerViewModel>().planCount,
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
