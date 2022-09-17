import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:arnhss/features/planner/view_model/planner_view.dart';
import 'package:arnhss/features/planner/widgets/date_timline.dart';
import 'package:arnhss/features/planner/widgets/floating_button.dart';
import 'package:arnhss/features/planner/widgets/not_found.dart';
import 'package:arnhss/features/planner/widgets/planner_app_bar.dart';
import 'package:arnhss/features/planner/widgets/task_tile/task_tile.dart';

import 'package:shimmer/shimmer.dart';

class PlannerView extends StatelessWidget {
  const PlannerView({Key? key}) : super(key: key);
  static const routeName = '/task_view';
  // static final PageController _controller =
  //     PageController(initialPage: DateTime.now().day);

  @override
  Widget build(BuildContext context) {
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
                // NotFound(),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: context.read<PlannerViewModel>().pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: FutureBuilder<List<PlannerModel>>(
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                    10,
                                    (index) => Shimmer.fromColors(
                                      baseColor: CustomColors.bgOverlay,
                                      highlightColor:
                                          CustomColors.light.withOpacity(.4),
                                      child: const TaskTile(isSkelton: true),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const NotFound();
                            }
                            return ListView.builder(
                              itemBuilder: ((context, index) =>
                                  const TaskTile()),
                              itemCount: snapshot.data!.length,
                            );
                          }),
                          future: context
                              .read<PlannerViewModel>()
                              .getTasksOfTheDay(DateTime.now()),
                        ),
                      );
                    },
                    onPageChanged: (day) {
                      context.read<PlannerViewModel>().swipePage(day);
                    },
                  ),
                )
              ],
            ),
            const FloatingButton()
          ],
        ),
      ),
    );
  }
}
