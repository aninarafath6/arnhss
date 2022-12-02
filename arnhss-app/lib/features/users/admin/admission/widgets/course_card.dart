import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
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
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      );
    } else {
      return Dismissible(
        key: UniqueKey(),
        confirmDismiss: ((direction) async {
          print(course?.id);
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
