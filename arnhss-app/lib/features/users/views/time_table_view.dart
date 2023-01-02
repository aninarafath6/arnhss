import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/features/users/view_model/timetable_view_model.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({Key? key}) : super(key: key);

  static const String routeName = "/timeTable";

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TimetableViewModel>().getTimeTable(
            batchRef: context.read<BatchViewModel>().selectedBatch.reference!,
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var watcher = context.watch<TimetableViewModel>();
    var reader = context.read<TimetableViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: CustomColors.dark,
          ),
        ),
        title: Text(
          "Time Table",
          style: CustomTextTheme(context: context)
              .headLine()
              .copyWith(fontSize: 20),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  watcher.workingDays.length,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      setState(() {
                        reader.setSelectedIndex = index;
                      });
                      _pageController.animateToPage(reader.selectedIndex,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.ease);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: watcher.selectedIndex == index
                            ? Colors.black
                            : CustomColors.lightBgOverlay,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          watcher.workingDays[index],
                          style: TextStyle(
                              color: watcher.selectedIndex == index
                                  ? Colors.white
                                  : CustomColors.dark),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          preferredSize: const Size(double.infinity, 70),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: watcher.workingDays.length,
        onPageChanged: (value) {
          setState(
            () {
              reader.setSelectedIndex = value;
            },
          );

          context.read<TimetableViewModel>().getScheduleOfDay();
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: watcher.loading
                ? ListView(
                    children: List.generate(
                      7,
                      (index) {
                        return Shimmer.fromColors(
                          baseColor: CustomColors.bgOverlay,
                          highlightColor: CustomColors.light.withOpacity(.5),
                          child: const TimeTableCard(
                            isLoading: true,
                            index: 0,
                          ),
                        );
                      },
                    ),
                  )
                : watcher.schedule != null
                    ? ListView.builder(
                        itemBuilder: ((context, index) {
                          if (index < watcher.schedule!.schedule.length) {
                            return TimeTableCard(
                              period: watcher.schedule?.schedule[index],
                              index: index,
                            );
                          } else {
                            return TimeTableCard(
                              index: index,
                            );
                          }
                        }),
                        itemCount: 7,
                      )
                    : context.read<UserViewModel>().user?.role == Role.student
                        ? const Padding(
                            padding: EdgeInsets.all(50.0),
                            child: NotFound(
                              imageURL: "assets/images/icons/desk.png",
                              title:
                                  "As of yet, the timetable for the project has not been finalized.",
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: ((context, index) {
                              return TimeTableCard(
                                index: index,
                              );
                            }),
                            itemCount: 7,
                          ),
          );
        },
      ),
    );
  }
}

class TimeTableCard extends StatelessWidget {
  const TimeTableCard(
      {Key? key, this.period, this.isLoading = false, required this.index})
      : super(key: key);

  final Period? period;
  final bool isLoading;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: period == null && !isLoading
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              child: DottedBorder(
                dashPattern: const [5, 5],
                strokeCap: StrokeCap.butt,
                color: CustomColors.light,
                strokeWidth: 1,
                child: GestureDetector(
                  onTap: () {
                    showScheduleForm(
                      context,
                      title: "Schedule for (${index + 1})",
                      onSubmit: () {
                        context.read<TimetableViewModel>().addSchedule(
                            index,
                            context
                                .read<BatchViewModel>()
                                .selectedBatch
                                .reference!, () {
                          Navigator.pop(context);
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.lightBgOverlay,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Schedule now",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            "(${index + 1})",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 80,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: CustomColors.lightBgOverlay,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? Container(
                              width: 100,
                              height: 15,
                              color: Colors.green,
                            )
                          : Text(
                              "${period?.subject.name ?? ""} (${period?.name ?? ""})",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                      isLoading
                          ? Container(
                              width: 50,
                              height: 10,
                              margin: const EdgeInsets.only(top: 5),
                              color: Colors.green,
                            )
                          : Text(
                              "- ${period?.teacher.name ?? ""}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      isLoading
                          ? Container(
                              width: 30,
                              height: 8,
                              color: Colors.green,
                            )
                          : Text(
                              period?.startTime.format(context) ?? "",
                              style: const TextStyle(fontSize: 12),
                            ),
                      const SizedBox(height: 20),
                      isLoading
                          ? Container(
                              width: 30,
                              height: 8,
                              color: Colors.green,
                            )
                          : Text(
                              period?.endTime.format(context) ?? "",
                              style: const TextStyle(fontSize: 12),
                            ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
