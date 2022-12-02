import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/batch_model.dart';
import 'package:shimmer/shimmer.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({
    Key? key,
    this.batch,
    this.isSkelton = false,
  }) : super(key: key);

  final Batch? batch;
  final bool isSkelton;

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
        : ListTile(
            title: Text(batch?.name ?? "no name"),
            subtitle: Text(
              "Batch code: ${batch?.code}",
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          );
  }
}
