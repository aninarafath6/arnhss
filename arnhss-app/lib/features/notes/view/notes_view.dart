import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/tile.dart';
import 'package:arnhss/features/notifications/view/notification_view.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:arnhss/features/planner/widgets/add_plan_bottom_form.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:remixicon/remixicon.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // 1
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 28,
          icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark),
        ),
        title: const Text(
          "Notes",
          style: TextStyle(color: CustomColors.dark),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.default_padding),
        child: StaggeredGrid.count(
          crossAxisCount: 6,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: const [
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/pngs/notes/data-science.png",
                label: "Computer Science",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/pngs/notes/math.png",
                label: "Maths",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/pngs/notes/physics.png",
                label: "Physics",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/pngs/notes/chemistry.png",
                label: "Chemistry",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 2,
                image: "assets/images/pngs/notes/understanding.png",
                label: "English",
                count: 3,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/pngs/notes/language.png",
                label: "Language",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
