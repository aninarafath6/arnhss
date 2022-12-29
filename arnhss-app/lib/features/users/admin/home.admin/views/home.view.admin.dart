import 'dart:developer';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/views/admission_view.dart';
import 'package:arnhss/features/users/admin/home.admin/views/all_teacher.dart';
import 'package:arnhss/features/users/admin/home.admin/views/notice.view.admin.dart';
import 'package:arnhss/features/users/student/home/widgets/app_drawer.dart';
import 'package:arnhss/features/users/student/home/widgets/qout_0f_the_day.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/features/users/widget/add_notice_sheet.dart';
import 'package:arnhss/features/users/widget/custom_app_bar.dart';
import 'package:arnhss/features/users/student/home/widgets/home_grid.dart';
import 'package:arnhss/features/users/widget/notice_item.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/features/users/service/notice_service.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/shared_pref_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AdminHome extends StatefulWidget {
  static const routeName = "/home";

  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    context.read<UserViewModel>().getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<StaggeredGridTile> adminElements = [
      StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3.8,
        child: Tile(
          index: 0,
          image: "assets/images/icons/education-badge.png.webp",
          label: "Admission",
          onTap: () => Navigator.pushNamed(context, AdmissionView.routeName),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 3,
        mainAxisCellCount: 3,
        child: Tile(
          index: 1,
          image: "assets/images/icons/marketing-badge.png.webp",
          label: " Notices",
          count: 1,
          onTap: () => Navigator.pushNamed(context, NoticeView.routeName),
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
            showAddNotice(context);
          },
          child: const Center(
            child: Text(
              "Post a notice",
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
          image: "assets/images/icons/oc-taking-note-removebg-preview (1).png",
          label: "Planner",
          count: 0,
          onTap: () => Navigator.pushNamed(context, PlannerView.routeName),
        ),
      ),
      StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: 2,
        child: Tile(
          index: 4,
          image: "assets/images/icons/teacher.png",
          label: "Teachers",
          onTap: () =>
              Navigator.pushNamed(context, AllTeacherListView.routeName),
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
        if (error.toString().contains("firebase_database/permission-denied")) {
          HandleException().handleException(error);
          SharedPrefService().clear();
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        }
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
                role: value.user?.role,
                notice: Provider.of<NoticeModel?>(context),
              ),
              HomeGrid(elements: adminElements),
              // const SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
