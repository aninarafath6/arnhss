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
    debugPrint("Individual note view build build");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 75),
        child: Consumer<NotesViewModel>(
          builder: (context, value, child) {
            return searchAppBar(context,
                type: Brightness.light,
                onTap: () {
                  if (value.isSearching) {
                    focusNode.unfocus();
                    value.toggleSearching();
                  } else {
                    Navigator.pop(context);
                  }
                },
                center: true,
                searching: value.isSearching,
                focusNode: focusNode,
                onSearchTap: () {
                  value.toggleSearching();
                  if (value.isSearching) {
                    focusNode.requestFocus();
                  }
                },
                hintText: "Search notes...",
                title: subject?.name ?? "");
          },
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: context.read<NotesViewModel>().getNotes(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(" waiting"),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text(" not data found"),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Center(
                child: Text(snapshot.data![index]),
              );
            },
            itemCount: snapshot.data?.length,
          );
        }),
      ),
    );
  }
}
