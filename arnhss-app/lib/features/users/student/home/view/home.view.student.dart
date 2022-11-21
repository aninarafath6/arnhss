import 'dart:developer';

import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/features/users/student/home/widgets/app_drawer.dart';
import 'package:arnhss/features/users/widget/custom_app_bar.dart';
import 'package:arnhss/features/users/student/home/widgets/home_grid.dart';
import 'package:arnhss/features/users/widget/notice_item.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/features/users/service/notice_service.dart';

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
            children: const [
              NoticeItem(),
              HomeGrid(),
              SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
