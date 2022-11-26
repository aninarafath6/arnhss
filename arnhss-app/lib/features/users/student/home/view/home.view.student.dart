import 'dart:developer';

import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/features/users/student/home/widgets/app_drawer.dart';
import 'package:arnhss/features/users/widget/custom_app_bar.dart';
import 'package:arnhss/features/users/student/home/widgets/home_grid.dart';
import 'package:arnhss/features/users/widget/notice_item.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/features/users/service/notice_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/users/student/attendance/view/attendance_view.dart';
import 'package:arnhss/features/users/student/home/widgets/qout_0f_the_day.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/features/users/student/notes/view/notes_view.dart';
import 'package:arnhss/features/users/student/notifications/view/notification_view.dart';
import 'package:arnhss/features/users/student/planner/view/planner_view.dart';
import 'package:arnhss/features/users/student/planner/widgets/add_plan_bottom_form.dart';

class StudentHome extends StatefulWidget {
  static const routeName = "/home";

  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    context.read<UserViewModel>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<StaggeredGridTile> homeElements = [
      StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3.8,
        child: Tile(
          index: 0,
          image: "assets/images/icons/nt-to-do-list-removebg-preview.png",
          label: "Attendance",
          onTap: () => Navigator.pushNamed(context, AttendanceView.routeName),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3,
        child: Tile(
          index: 1,
          image: "assets/images/icons/oc-taking-note-removebg-preview (1).png",
          label: "Planner",
          count: 3,
          onTap: () => Navigator.pushNamed(context, PlannerView.routeName),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: .8,
        child: TextButton(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey.shade800.withOpacity(.9)),
            backgroundColor: MaterialStateProperty.all(
              CustomColors.dark,
            ),
          ),
          onPressed: () {
            showAddPlanForm(context);
          },
          child: const Center(
            child: Text(
              "Add Plan",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Tile(
          index: 3,
          image: "assets/images/icons/oc-plane-removebg-preview.png",
          count: 2,
          label: "Notifications",
          onTap: () => Navigator.pushNamed(context, NotificationView.routeName),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Tile(
          index: 4,
          image: "assets/images/icons/growing-books.png.webp",
          label: "Notes",
          onTap: () => Navigator.pushNamed(context, NotesView.routeName),
        ),
      ),
      const StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Tile(
          index: 4,
          image: "assets/images/icons/planning-badge.png.webp",
          label: "Time Table",
        ),
      ),
      const StaggeredGridTile.count(
        crossAxisCellCount: 6,
        mainAxisCellCount: 3.4,
        child: QoutOfTheDay(),
      ),
    ];

    debugPrint("===== Admin home view build =====");
    return StreamProvider<NoticeModel?>.value(
      value: NoticeService().notice,
      catchError: ((context, error) {
        log(error.toString(), name: " admin home view");
        return null;
      }),
      initialData: null,
      child: Consumer<UserViewModel>(builder: (context, value, _) {
        return Scaffold(
          key: context.read<UserViewModel>().scaffoldKey,
          extendBodyBehindAppBar: false,
          drawerEnableOpenDragGesture: false,
          drawer: const AppDrawer(),
          appBar: customHomeAppBar(context, value.user),
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              NoticeItem(
                notice: Provider.of<NoticeModel?>(context),
              ),
              HomeGrid(elements: homeElements),
              const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
