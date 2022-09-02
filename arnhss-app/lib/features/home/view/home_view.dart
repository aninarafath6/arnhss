import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/custom_app_bar.dart';
import 'package:arnhss/features/home/widgets/home_grid.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home ";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: customHomeAppBar(),
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
