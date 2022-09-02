import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/notice_list.dart';
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
          children: [
            // const SizedBox(height: 20),
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
                    child: Tile(
                      index: 0,
                      image:
                          "assets/images/icons/nt-to-do-list-removebg-preview.png",
                      label: "Attendance",
                    ),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 3,
                    mainAxisCellCount: 3,
                    child: Tile(
                      index: 1,
                      image:
                          "assets/images/icons/oc-taking-note-removebg-preview (1).png",
                      label: "Task",
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
                    child: Tile(
                        index: 3,
                        image:
                            "assets/images/icons/oc-plane-removebg-preview.png",
                        label: "Notifications"),
                  ),
                  const StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Tile(
                      index: 4,
                      image:
                          "assets/images/icons/oc-hand-holding-papers-removebg-preview.png",
                      label: "Notes",
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
                    mainAxisCellCount: 3,
                    child: Tile(
                      index: 6,
                      image:
                          "assets/images/icons/nt-people-holding-cards-removebg-preview.png",
                      label: "Activity",
                      isSmall: false,
                    ),
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
  const Tile({
    Key? key,
    this.index,
    this.image = "assets/images/icons/design-badge.png.webp",
    this.label = "label",
    this.isSmall = true,
  }) : super(key: key);
  final int? index;
  final String? image;
  final String? label;
  final bool? isSmall;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
            top: 10, bottom: isSmall! ? 10 : 0, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.grey.withOpacity(.1),
        ),
        child: Center(
          child: Column(
            verticalDirection:
                isSmall! ? VerticalDirection.down : VerticalDirection.up,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const Spacer(flex: 3),
              Expanded(
                child: Image.asset(
                  image!,
                  width: isSmall! ? 100 : 300,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment:
                    isSmall! ? Alignment.bottomCenter : Alignment.topLeft,
                child: Text(
                  label!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
