import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';
import 'package:arnhss/features/home/widgets/app_drawer.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_item.dart';
// import 'package:arnhss/features/home/widgets/notice_item.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:arnhss/services/firebase_database_service.dart';

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
    return StreamProvider<NoticeModel?>.value(
      value: FireBaseDatabaseService().notice,
      catchError: ((context, error) {
        // HandleException().handleException(error);
        return null;
      }),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: NoticeItem(),
              ),
              // QoutOfTheDay(),x
              HomeGrid(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
