import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<HomeViewModel>().scaffoldKey,
      extendBodyBehindAppBar: true,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        width: context.getWidth(80),
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: CustomColors.light.withOpacity(.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/images/icons/hero.png.webp"),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
