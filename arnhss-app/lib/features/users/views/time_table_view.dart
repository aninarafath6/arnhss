import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_app_bar.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/services.dart';

class TimeTableView extends StatefulWidget {
  const TimeTableView({Key? key}) : super(key: key);

  static const String routeName = "/timeTable";

  @override
  State<TimeTableView> createState() => _TimeTableViewState();
}

class _TimeTableViewState extends State<TimeTableView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> workingDays = ["M", "T", "W", "T", "F"];
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
                      setState(
                        () {
                          selectedIndex = index;
                        },
                      );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            ...List.generate(
              7,
              (index) {
                if (index == 2 || index == 4 || index == 6) {
                  return Column(
                    children: [
                      BreakTime(
                        startTime: "09:00",
                        endTime: "10:30",
                        title: index == 2 || index == 6
                            ? "INTERVAL"
                            : "LUNCH BREAK",
                      ),
                      TimeTableCard(
                        subjectName: "Mathematics",
                        startTime: "09:00",
                        endTime: "10:30",
                        index: index,
                      ),
                    ],
                  );
                } else {
                  return TimeTableCard(
                    subjectName: "Mathematics",
                    startTime: "09:00",
                    endTime: "10:30",
                    index: index,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BreakTime extends StatelessWidget {
  const BreakTime({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.title,
  }) : super(key: key);
  final String title;
  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      width: context.getWidth(100),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                ...List.generate(
                  context.getWidth(9).round(),
                  (index) => Transform.rotate(
                    angle: 120,
                    child: Container(
                      height: 40,
                      width: 1,
                      margin: const EdgeInsets.only(right: 10),
                      color: index % 2 == 0
                          ? Colors.black
                          : CustomColors.halfColor,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              // right: context.getWidth(50),
              child: Container(
                height: 40,
                // width: 200,
                color: Colors.white.withOpacity(.99),

                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Center(
                  child: Text(
                    "$title ($startTime - $endTime)",
                    style: const TextStyle(color: CustomColors.dark),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimeTableCard extends StatelessWidget {
  const TimeTableCard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.subjectName,
    required this.index,
  }) : super(key: key);
  final String subjectName;
  final String startTime;
  final String endTime;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      startTime,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      endTime,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              DottedLine(
                direction: Axis.vertical,
                lineLength: index == 0 || index == 2
                    ? 80
                    : index == 6 || index == 1
                        ? 85
                        : 90,
                lineThickness: 1.5,
                dashLength: 5.0,
                dashColor: Colors.black.withOpacity(.8),
                dashGapLength: 2.0,
              )
            ],
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            color: CustomColors.lightBgOverlay,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$subjectName (${index + 1})",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "- Shaija Miss",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
