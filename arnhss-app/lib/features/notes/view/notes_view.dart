import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/tile.dart';
import 'package:arnhss/features/notes/view_model/notes_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math' as math;

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    var _readProvider = context.read<NotesViewModel>();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.default_padding,
            right: AppSizes.default_padding,
            top: AppSizes.default_padding,
            bottom: 30,
          ),
          child: StaggeredGrid.count(
            crossAxisCount: 6,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            children: List.generate(
              _readProvider.selectedDepartment.subjects!.length,
              (index) => StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: 3,
                child: Tile(
                  index: 0,
                  image: _readProvider
                      .selectedDepartment.subjects![index].imageURL,
                  label: _readProvider.selectedDepartment.subjects![index].name,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
