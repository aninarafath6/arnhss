import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';
import 'package:arnhss/features/home/widgets/app_drawer.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:arnhss/features/home/widgets/qout_0f_the_day.dart';
import 'package:arnhss/services/firebase_database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  static const routeName = "/home";

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeViewModel>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Home build");
    return StreamProvider<QuerySnapshot?>.value(
      value: FireBaseDatabaseService().notices,
      initialData: null,
      child: Scaffold(
        key: context.read<HomeViewModel>().scaffoldKey,
        extendBodyBehindAppBar: false,
        drawerEnableOpenDragGesture: false,
        drawer: const AppDrawer(),
        appBar: customHomeAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(),
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: const [
              NoticeList(),
              HomeGrid(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
