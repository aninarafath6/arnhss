import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batch_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/add_course_form.dart';
import 'package:arnhss/features/users/student/home/widgets/tile.dart';
import 'package:arnhss/features/users/student/planner/widgets/add_plan_bottom_form.dart';
import 'package:arnhss/features/users/widget/add_notice_sheet.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:remixicon/remixicon.dart';

class CourseView extends StatefulWidget {
  const CourseView({
    Key? key,
    required this.selectedCourse,
  }) : super(key: key);
  final Course selectedCourse;
  static const String routeName = "/batch_view";

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BatchViewModel>().getBatches(widget.selectedCourse);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: widget.selectedCourse.name,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position:
                    const RelativeRect.fromLTRB(double.infinity, 10, 10, 0),
                items: [
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<AdmissionViewModel>()
                            .setUpToUpdate(widget.selectedCourse);
                        showCourseForm(
                          context,
                          title: "Edit Course",
                          buttonTXT: "Update",
                          onSubmit: () async {
                            bool status = await context
                                .read<AdmissionViewModel>()
                                .update(widget.selectedCourse);

                            if (!status) {
                              HandleException().handleException(
                                InvalidException(
                                    "Sorry, course not updated ", false),
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
                      },
                      child: Row(
                        children: const [
                          Icon(Remix.edit_line),
                          SizedBox(width: 15),
                          Text("Edit Course"),
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: Material(
                      child: GestureDetector(
                        onTap: () async {
                          bool status = false;
                          await courseModal(
                            context,
                            content:
                                "If you agree to the deletion of this course, can we proceed?",
                            title: "Delete Course?",
                            deny: "DENY",
                            done: "SURE".toText(
                                style: const TextStyle(color: Colors.red)),
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
                            context
                                .read<AdmissionViewModel>()
                                .deleteCourse(widget.selectedCourse);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: Row(
                          children: const [
                            Icon(Remix.delete_bin_line),
                            SizedBox(width: 15),
                            Text("Delete Course"),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
            splashRadius: 20,
            icon: const Icon(
              Remix.menu_5_line,
              color: Colors.black,
            ),
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
                  DText(value: widget.selectedCourse.name, name: "Name"),
                  const Divider(),
                  DText(
                    value: widget.selectedCourse.d_code,
                    name: "Display code",
                  ),
                  const Divider(),
                  DText(value: widget.selectedCourse.code, name: "Code"),
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
                          .getCourseData(widget.selectedCourse)),
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
                          .getCourseData(widget.selectedCourse)),
                ],
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 3,
              child: Tile(
                index: 0,
                image: "assets/images/icons/notes.png",
                label: "Subjects",
              ),
            ),
            const StaggeredGridTile.count(
              crossAxisCellCount: 3,
              mainAxisCellCount: 6,
              child: Tile(
                index: 1,
                image: "assets/images/icons/sales-and-crm-badge.png.webp",
                label: "Batches",
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

      // child: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: AppSizes.default_padding - 10,
      //     vertical: 5,
      //   ),
      //   child: Consumer<BatchViewModel>(
      //     builder: (context, value, _) {
      //       return value.loading
      //           ? ListView.builder(
      //               itemCount: 5,
      //               itemBuilder: (context, index) => BatchCard(
      //                   isSkelton: true, course: widget.selectedCourse),
      //             )
      //           : value.batchCount == 0
      //               ? NotFound(
      //                   imageURL:
      //                       "assets/images/icons/spot-workflow.png.webp",
      //                   title:
      //                       "Unfortunately, no batch have been found under the ${widget.selectedCourse.name} course for this time",
      //                 )
      //               : ListView.builder(
      //                   itemCount: value.batchCount,
      //                   itemBuilder: (BuildContext context, index) {
      //                     Batch batch = value.batches[index];

      //                     return BatchCard(
      //                         batch: batch, course: widget.selectedCourse);
      //                   },
      //                 );
      //     },
      //   ),
      // ),
      // ),
      // floatingActionButton: TextButton(
      //   onPressed: () {

      //     context.read<BatchViewModel>().clearControllers();
      //     context.read<BatchViewModel>().setUpForAdd(widget.selectedCourse);

      //     showBatchForm(
      //       context,
      //       course: widget.selectedCourse,
      //       onSubmit: () async {
      //         bool status = await context
      //             .read<BatchViewModel>()
      //             .addBatch(widget.selectedCourse);

      //         if (!status) {
      //           // HandleException().handleException(
      //           //   InvalidException("Sorry, course not added ", false),
      //           //   top: true,
      //           // );
      //         } else {
      //           DialogHelper.showSnackBar(
      //             title: "Success🤡",
      //             description: "Batch added successfully ✔️",
      //           );
      //           Navigator.of(context).pop();
      //         }
      //       },
      //     );
      //   },
      //   child: Container(
      //     padding: const EdgeInsets.all(12),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(5),
      //       color: CustomColors.dark,
      //     ),
      //     child: const Icon(Remix.add_fill, color: Colors.white),
      //   ),
      // ),
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
