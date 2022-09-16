import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/tasks/models/task_model.dart';
import 'package:arnhss/features/tasks/view_model/task_view_model.dart';
import 'package:arnhss/features/tasks/widgets/date_timline.dart';
import 'package:arnhss/features/tasks/widgets/floating_button.dart';
import 'package:arnhss/features/tasks/widgets/not_found.dart';
import 'package:arnhss/features/tasks/widgets/task_app_bar.dart';
import 'package:arnhss/features/tasks/widgets/task_tile/task_tile.dart';
import 'package:shimmer/shimmer.dart';

class TaskView extends StatelessWidget {
  const TaskView({Key? key}) : super(key: key);
  static const routeName = '/task_view';
  static final PageController _controller =
      PageController(initialPage: DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: taskAppBar(context),
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
                    controller: context.read<TaskViewModel>().pageController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: FutureBuilder<List<TaskModel>>(
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
                              .read<TaskViewModel>()
                              .getTasksOfTheDay(DateTime.now()),
                        ),
                      );
                    },
                    onPageChanged: (day) {
                      print(day);
                      context.read<TaskViewModel>().swipePage(day);
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
