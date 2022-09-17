import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/attendance/view/attendance_view.dart';
import 'package:arnhss/features/home/widgets/tile.dart';
import 'package:arnhss/features/planner/view/planner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 21, right: 21),
      child: StaggeredGrid.count(
        crossAxisCount: 6,
        mainAxisSpacing: 10,
        crossAxisSpacing: 8,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 3.8,
            child: Tile(
              index: 0,
              image: "assets/images/icons/nt-to-do-list-removebg-preview.png",
              label: "Attendance",
              onTap: () =>
                  Navigator.pushNamed(context, AttendanceView.routeName),
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 3,
            mainAxisCellCount: 3,
            child: Tile(
              index: 1,
              image:
                  "assets/images/icons/oc-taking-note-removebg-preview (1).png",
              label: "Planner",
              count: 3,
              onTap: () => Navigator.pushNamed(context, PlannerView.routeName),
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
                  "Add Plan",
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
              image: "assets/images/icons/oc-plane-removebg-preview.png",
              count: 2,
              label: "Notifications",
            ),
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
              count: 10,
            ),
          ),
        ],
      ),
    );
  }
}
