import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/batch_view_model.dart';
import 'package:shimmer/shimmer.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({
    Key? key,
    this.batch,
    this.isSkelton = false,
    required this.course,
  }) : super(key: key);

  final Batch? batch;
  final bool isSkelton;
  final Course course;

  @override
  Widget build(BuildContext context) {
    return isSkelton
        ? Shimmer.fromColors(
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
              trailing: Container(
                width: 15,
                color: Colors.black,
                height: 25,
              ),
            ),
          )
        : Dismissible(
            key: UniqueKey(),
            confirmDismiss: ((direction) async {
              var status = false;
              await batchModal(
                context,
                content:
                    "If you agree to the deletion of this batch, can we proceed?",
                title: "Delete Batch?",
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
            onDismissed: (direction) => context
                .read<BatchViewModel>()
                .deleteCourse(batch, course: course),
            child: ListTile(
              title: Text(batch?.name ?? "no name"),
              subtitle: Text(
                "Batch code: ${batch?.code}",
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          );
  }
}
