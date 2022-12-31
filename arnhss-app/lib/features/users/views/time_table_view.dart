import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batches_view_model.dart';
import 'package:arnhss/features/users/student/planner/widgets/not_found.dart';
import 'package:arnhss/features/users/view_model/timetable_view_model.dart';
import 'package:arnhss/models/schedule.model.dart';
import 'package:flutter/services.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({Key? key}) : super(key: key);

  static const String routeName = "/timeTable";

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  List<String> workingDays = ["M", "T", "W", "T", "F"];

  @override
  void initState() {
    context.read<TimetableViewModel>().getTimeTableOfDay(
          batchRef: context.read<BatchViewModel>().selectedBatch.reference!,
          day: workingDays[selectedIndex],
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Schedule> subjects = [];
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
        elevation: .1,
        bottom: PreferredSize(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  workingDays.length,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(25),
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      _pageController.animateToPage(selectedIndex,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.ease);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? Colors.black
                            : CustomColors.lightBgOverlay,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          workingDays[index],
                          style: TextStyle(
                              color: selectedIndex == index
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
        itemCount: workingDays.length,
        onPageChanged: (value) {
          setState(
            () {
              selectedIndex = value;
            },
          );

          context.read<TimetableViewModel>().getTimeTableOfDay(
                batchRef:
                    context.read<BatchViewModel>().selectedBatch.reference!,
                day: workingDays[selectedIndex],
              );
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: subjects.isNotEmpty
                ? ListView(
                    children: List.generate(7, (index) {
                      return const TimeTableCard();
                    }),
                  )
                : const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: NotFound(
                      imageURL: "assets/images/icons/desk.png",
                      title:
                          "As of yet, the timetable for the project has not been finalized.",
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class TimeTableCard extends StatelessWidget {
  const TimeTableCard({Key? key, this.period}) : super(key: key);

  final Period? period;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
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
                        Text(
                          period?.subject.name ?? "",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          period?.teacher.name ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          period?.startTime.format(context) ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          period?.endTime.format(context) ?? "",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
