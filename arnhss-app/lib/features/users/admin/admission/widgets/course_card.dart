import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:arnhss/features/users/admin/admission/widgets/add_course_form.dart';
import 'package:arnhss/helpers/dialog_helper.dart';
import 'package:arnhss/services/base/exception/app_exceptions.dart';
import 'package:arnhss/services/base/exception/handle_exception.dart';
import 'package:shimmer/shimmer.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    this.course,
    this.isSkelton = false,
  }) : super(key: key);

  final Course? course;
  final bool isSkelton;

  @override
  Widget build(BuildContext context) {
    if (isSkelton) {
      return Shimmer.fromColors(
        baseColor: CustomColors.bgOverlay,
        highlightColor: CustomColors.light.withOpacity(.5),
        child: ListTile(
          title: Container(
            width: context.getWidth(80),
            color: Colors.black,
            height: 12,
          ),
          subtitle: Container(
            width: context.getWidth(80),
            color: Colors.black,
            height: 8,
            margin: const EdgeInsets.only(bottom: 4),
          ),
          leading: CircleAvatar(
            backgroundColor: CustomColors.bgOverlay,
            child: Text(course?.d_code ?? ""),
          ),
          trailing: Container(
            width: 15,
            color: Colors.black,
            height: 25,
          ),
        ),
      );
    } else {
      return Dismissible(
        key: UniqueKey(),
        confirmDismiss: ((direction) async {
          var status = false;
          await courseModal(
            context,
            content:
                "If you agree to the deletion of this course, can we proceed?",
            title: "Delete Course?",
            deny: "DENY",
            done: "SURE".toText(style: const TextStyle(color: Colors.red)),
            onDeny: () {
              status = false;
              Navigator.pop(context);
            },
            onDone: () {
              status = true;
              Navigator.pop(context);
            },
          );
          return status;
        }),
        onDismissed: (direction) =>
            context.read<AdmissionViewModel>().deleteCourse(course),
        child: ListTile(
          onLongPress: () {
            context.read<AdmissionViewModel>().setUpToUpdate(course!);
            showCourseForm(
              context,
              title: "Edit Course",
              buttonTXT: "Update",
              onSubmit: () async {
                bool status =
                    await context.read<AdmissionViewModel>().update(course!);

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
          },
          title: Text(course?.name ?? ""),
          subtitle: Text("Course code : ${course?.code}"),
          leading: CircleAvatar(
            backgroundColor: CustomColors.bgOverlay,
            child: Text(course?.d_code ?? ''),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      );
    }
  }
}
