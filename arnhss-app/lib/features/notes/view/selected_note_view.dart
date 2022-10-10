import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/routes/index_routes.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/common/widgets/search_app_bar.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/notes/model/department_mode.dart';
import 'package:arnhss/features/notes/model/note_model.dart';
import 'package:arnhss/features/notes/repo/pdf_view.dart';
import 'package:arnhss/features/notes/view/pdf_view.dart';
import 'package:arnhss/features/notes/view_model/notes_view_model.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 15, vertical: 0),
        child: FutureBuilder<List<Note>>(
          future: context.read<NotesViewModel>().getNotes(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text(" something error occurs"),
                );
              } else if (snapshot.data!.isEmpty) {
                return Container(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: NotFound(
                    title: "We have no notes",
                    subTitle:
                        "As of right now, we don't have any notes on the\n${subject?.name} To refer ",
                    imageURL: Images.noteNotFound,
                  ),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ListTile(
                      title: snapshot.data![index].name?.toText(),
                      subtitle: snapshot.data![index].sub?.toText(),
                      leading: Image.asset(
                        "assets/images/icons/pdf.png",
                        width: 50,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      minVerticalPadding: 6,
                      onTap: () async {
                        PdfService()
                            .getPdfFromNetwork(
                                "https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf")
                            .then(
                          (file) {
                            if (file!.path.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(path: file.path),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
                itemCount: snapshot.data?.length,
              );
            } else {
              return const Center(
                child: Text(" waiting"),
              );
            }
          }),
        ),
      ),
    );
  }
}
