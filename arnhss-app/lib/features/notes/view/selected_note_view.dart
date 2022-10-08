import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/features/notes/model/department_mode.dart';
import 'package:arnhss/features/notes/widgets/note_appBar.dart';

class SelectedNoteView extends StatelessWidget {
  const SelectedNoteView({Key? key, this.subject}) : super(key: key);
  final Subject? subject;
  static const routeName = "/selectedNote";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notesAppBar(context, subject?.name ?? "Notes"),
      body: Center(
        child: Text(" This is " + subject!.name! + " Page"),
      ),
    );
  }
}
