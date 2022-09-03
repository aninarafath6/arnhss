import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';
import 'package:arnhss/features/home/widgets/app_drawer.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:remixicon/remixicon.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/home";

  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<HomeViewModel>().scaffoldKey,
      extendBodyBehindAppBar: false,
      drawerEnableOpenDragGesture: false,
      drawer: const AppDrawer(),
      appBar: customHomeAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: const [
            NoticeList(),
            HomeGrid(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
