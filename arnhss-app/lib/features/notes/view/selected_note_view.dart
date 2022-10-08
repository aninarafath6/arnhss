import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/features/notes/model/department_mode.dart';
import 'package:arnhss/features/notes/view_model/notes_view_model.dart';
import 'package:provider/provider.dart';

class SelectedNoteView extends StatelessWidget {
  SelectedNoteView({Key? key, this.subject}) : super(key: key);
  final Subject? subject;
  final FocusNode focusNode = FocusNode();
  static const routeName = "/selectedNote";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchAppBar(context,
          type: Brightness.light,
          onTap: () {
            if (context.read<NotesViewModel>().isSearching) {
              focusNode.unfocus();
              context.read<NotesViewModel>().toggleSearching();
            } else {
              Navigator.pop(context);
            }
          },
          center: true,
          searching: context.watch<NotesViewModel>().isSearching,
          focusNode: focusNode,
          onSearchTap: () {
            context.read<NotesViewModel>().toggleSearching();
            if (context.read<NotesViewModel>().isSearching) {
              focusNode.requestFocus();
            }
          },
          hintText: "Search notes...",
          title: subject?.name ?? ""),
      body: Center(
        child: Text(" This is " + subject!.name! + " Page"),
      ),
    );
  }
}
