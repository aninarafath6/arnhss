import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/home/widgets/tile.dart';
import 'package:arnhss/features/notes/view/selected_note_view.dart';
import 'package:arnhss/features/notes/view_model/notes_view_model.dart';
import 'package:arnhss/features/notes/widgets/note_app_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    var _readProvider = context.read<NotesViewModel>();
    return Scaffold(
      appBar: notesAppBar(context, "Notes"),
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
                  onTap: () => Navigator.pushNamed(
                    context,
                    SelectedNoteView.routeName,
                    arguments:
                        _readProvider.selectedDepartment.subjects![index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
