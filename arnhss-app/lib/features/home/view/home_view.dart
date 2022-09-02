import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
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
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, // Don't show the leading button
        toolbarHeight: 100,
        title: Row(
          children: [
            IconButton(
              splashRadius: 28,
              onPressed: () {},
              icon:
                  const Icon(Remix.command_fill, color: Colors.black, size: 30),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Hey, Anin Arafath",
                    style: TextStyle(
                        color: CustomColors.dark, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(
                  "Monday, 4 march ",
                  style: TextStyle(
                    color: CustomColors.light,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        centerTitle: false,
      ),
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
