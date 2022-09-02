import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/blog_list.dart';
import 'package:arnhss/features/home/widgets/home_banner.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
import 'package:arnhss/features/home/widgets/user_avatar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leadingWidth: 60,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
        elevation: 0,
        leading:
            const Icon(Remix.menu_4_line, color: Colors.transparent, size: 30),
        actions: const [UserAvatar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24.0, right: 24, top: 20),
              child: HomeBanner(),
            ),
            const SizedBox(height: 35),
            // Padding(
            //   padding: EdgeInsets.all(24.0),
            //   child: QoutOfTheDay(),
            // ),
            const NoticeList(),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, top: 20),
              child: StaggeredGrid.count(
                crossAxisCount: 6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 8,
                children: [
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3.8,
                    child: Tile(index: 0),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3,
                    child: Tile(index: 1),
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
                          )),
                      onPressed: () {},
                      child: const Center(
                        child: Text(
                          "Add Task",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 3),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 4),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(index: 5),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 6,
                    mainAxisCellCount: 3,
                    child: Tile(index: 6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // BlogList()
          ],
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.grey[300],
      ),
      child: Center(child: Text(index.toString())),
    );
  }
}
