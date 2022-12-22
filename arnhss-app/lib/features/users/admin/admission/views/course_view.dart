import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/views/batches_view.dart';
import 'package:arnhss/features/users/admin/admission/widgets/forms.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:remixicon/remixicon.dart';

enum Choice { delete, update }

class CourseView extends StatelessWidget {
  const CourseView({
    Key? key,
    // required this.selectedCourse,
  }) : super(key: key);
  // final Course selectedCourse;
  static const String routeName = "/batch_view";

  @override
  Widget build(BuildContext context) {
    Course watchCourse = context.watch<AdmissionViewModel>().selectedCourse;
    return Scaffold(
      appBar: customAppBar(
        context,
        title: watchCourse.name,
        actions: [
          PopupMenuButton<Choice>(
            icon: const Icon(
              Remix.menu_5_line,
              color: Colors.black,
            ),
            enableFeedback: true,
            onSelected: (value) async {
              if (value == Choice.update) {
                context.read<AdmissionViewModel>().setUpToUpdate(watchCourse);
                showCourseForm(
                  context,
                  title: "Edit Course",
                  buttonTXT: "Update",
                  onSubmit: () async {
                    bool status = await context
                        .read<AdmissionViewModel>()
                        .update(watchCourse);

                    if (!status) {
                      HandleException().handleException(
                        InvalidException("Sorry, course not updated ", false),
                        top: true,
                      );
                    } else {
                      DialogHelper.showSnackBar(
                        title: "Success😊",
                        description: "Course updated successfully ✔️",
                      );
                      Navigator.of(context).pop();
                    }
                  },
                );
              } else {
                bool status = false;
                await courseModal(
                  context,
                  content:
                      "If you agree to the deletion of this course, can we proceed?",
                  title: "Delete Course?",
                  deny: "DENY",
                  done:
                      "SURE".toText(style: const TextStyle(color: Colors.red)),
                  onDeny: () {
                    status = false;
                    Navigator.pop(context);
                  },
                  onDone: () {
                    status = true;
                    Navigator.pop(context);
                  },
                );

                if (status) {
                  context.read<AdmissionViewModel>().deleteCourse(watchCourse);
                  Navigator.pop(context);
                }
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Choice.update,
                child: MenuChip(
                  name: "Edit Course",
                  icon: Remix.edit_line,
                ),
              ),
              const PopupMenuItem(
                value: Choice.delete,
                child: MenuChip(
                  name: "Delete Course",
                  icon: Remix.delete_bin_line,
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.default_padding,
          vertical: 5,
        ),
        child: StaggeredGrid.count(
          crossAxisCount: 6,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 6,
              mainAxisCellCount: 4.5,
              child: DetailCard(
                listData: [
                  DText(value: watchCourse.name, name: "Name"),
                  const Divider(),
                  DText(
                    value: watchCourse.d_code,
                    name: "Display code",
                  ),
                  const Divider(),
                  DText(value: watchCourse.code, name: "Code"),
                  const Divider(),
                  FutureBuilder<Map<String, String?>>(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DText(
                          value: snapshot.data!["batches"] ?? "",
                          name: "Batches",
                        );
                      }
                      return const DText(
                        value: "...",
                        name: "Batches",
                      );
                    },
                    future: context
                        .read<AdmissionViewModel>()
                        .getCourseData(watchCourse),
                  ),
                  const Divider(),
                  FutureBuilder<Map<String, String?>>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DText(
                            value: snapshot.data!["students"] ?? "",
                            name: "Students",
                          );
                        }
                        return const DText(
                          value: "...",
                          name: "Students",
                        );
                      },
                      future: context
                          .read<AdmissionViewModel>()
                          .getCourseData(watchCourse)),
                ],
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 5,
              child: Tile(
                index: 0,
                image: "assets/images/icons/notes.png",
                label: "Subjects",
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 8,
              child: Tile(
                index: 1,
                image: "assets/images/icons/sales-and-crm-badge.png.webp",
                label: "Batches",
                onTap: () => Navigator.of(context).pushNamed(
                  BatchesView.routeName,
                  arguments: watchCourse,
                ),
                count: 0,
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/icons/woman-answering-phone.png.webp",
                label: "Teachers",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuChip extends StatelessWidget {
  const MenuChip({
    Key? key,
    required this.icon,
    required this.name,
  }) : super(key: key);
  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        const SizedBox(width: 15),
        Text(name),
      ],
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({
    Key? key,
    required this.listData,
  }) : super(key: key);

  final List<Widget> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listData,
      ),
    );
  }
}

class DText extends StatelessWidget {
  const DText({
    Key? key,
    required this.value,
    required this.name,
  }) : super(key: key);

  final String value;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          maxLines: 3,
          style: CustomTextTheme(context: context).headLine().copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
        ),
        const Spacer(),
        AnimatedSwitcher(
          key: ValueKey(value),
          duration: const Duration(milliseconds: 800),
          child: Text(
            value,
            key: UniqueKey(),
            maxLines: 3,
            style: CustomTextTheme(context: context).headLine().copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
          ),
        ),
      ],
    );
  }
}
