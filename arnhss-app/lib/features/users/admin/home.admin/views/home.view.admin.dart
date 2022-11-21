import 'dart:developer';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/home/model/notice_model.dart';
import 'package:arnhss/features/users/student/home/widgets/app_drawer.dart';
import 'package:arnhss/features/users/widget/custom_app_bar.dart';
import 'package:arnhss/features/users/student/home/widgets/home_grid.dart';
import 'package:arnhss/features/users/student/home/widgets/notice_item.dart';
import 'package:arnhss/features/users/view_model/user_view_model.dart';
import 'package:arnhss/services/firebase_database_service.dart';

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
    debugPrint("===== Admin home view build =====");
    return StreamProvider<NoticeModel?>.value(
      value: FireBaseDatabaseService().notice,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: NoticeItem(),
              ),
              HomeGrid(),
              SizedBox(height: 10),
            ],
          ),
        );
      }),
    );
  }
}
