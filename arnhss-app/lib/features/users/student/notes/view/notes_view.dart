import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/features/users/student/notes/view/selected_note_view.dart';
import 'package:arnhss/features/users/student/notes/widgets/note_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);
  static const routeName = "/notes";

  @override
  Widget build(BuildContext context) {
    debugPrint("Notes view build");

    var sub = [];
    // var sub = _readProvider
    // .getSubjects(context.read<HomeViewModel>().user?.department)
    // .subjects!;
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
              sub.length,
              (index) => StaggeredGridTile.count(
                crossAxisCellCount: 3,
                mainAxisCellCount: index % 2 == 0
                    ? sub.length > 6
                        ? 3
                        : 4.4
                    : sub.length > 6
                        ? 4
                        : 3.4,
                child: Tile(
                  index: 0,
                  image: sub[index].imageURL,
                  label: sub[index].name,
                  onTap: () => Navigator.pushNamed(
                    context,
                    SelectedNoteView.routeName,
                    arguments: sub[index],
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
