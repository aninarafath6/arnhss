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
  // static final PageController _controller =
  //     PageController(initialPage: DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    var _plans = context.read<PlannerViewModel>().plans;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                              return PlannerTile(plan: _plans[index]);
                            },
                            itemCount:
                                context.watch<PlannerViewModel>().plans.length,
                          ),
                  ),
                ),
                // Expanded(
                //   child: PageView.builder(
                //     physics: const NeverScrollableScrollPhysics(),
                //     controller: context.read<PlannerViewModel>().pageController,
                //     itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(
                //             left: 21.0, right: 21, top: 21),

                //         // child: FutureBuilder<List<PlannerModel>>(
                //         //   builder: ((context, snapshot) {
                //         //     if (snapshot.connectionState ==
                //         //         ConnectionState.waiting) {
                //         //       return SingleChildScrollView(
                //         //         physics: const NeverScrollableScrollPhysics(),
                //         //         child: Column(
                //         //           children: List.generate(
                //         //             10,
                //         //             (index) => Shimmer.fromColors(
                //         //               baseColor: CustomColors.bgOverlay,
                //         //               highlightColor:
                //         //                   CustomColors.light.withOpacity(.4),
                //         //               child: const PlanSkelton(),
                //         //             ),
                //         //           ),
                //         //         ),
                //         //       );
                //         //     }
                //         //     if (snapshot.data!.isEmpty) {
                //         //       return const NotFound();
                //         //     }

                //         //     return ListView.builder(
                //         //       physics: const PageScrollPhysics(),
                //         //       itemBuilder: ((context, index) => PlannerTile(
                //         //             plan: snapshot.data![index],
                //         //           )),
                //         //       itemCount: snapshot.data!.length,
                //         //     );
                //         //   }),
                //         //   future: context
                //         //       .read<NewPlanViewModel>()
                //         //       .getTasksOfTheDay(context
                //         //           .watch<PlannerViewModel>()
                //         //           .selectedDate),
                //         // ),
                //       );
                //     },
                //     onPageChanged: (day) {
                //       context.read<PlannerViewModel>().swipePage(day);
                //     },
                //   ),
                // )
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
