import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_chip.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/planner/models/planner_model.dart';
import 'package:arnhss/features/planner/view_model/planner_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';

class PlannerTile extends StatelessWidget {
  const PlannerTile({Key? key, this.isSkelton = false, required this.plan})
      : super(key: key);
  final PlannerModel plan;
  final bool isSkelton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        key: ValueKey(key),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (_) =>
                  context.read<PlannerViewModel>().deletePlan(plan.id!),
              backgroundColor: Colors.transparent,
              foregroundColor: CustomColors.absentColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(21),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: CustomColors.lightBgOverlay,
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.title ?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      plan.note ?? "",
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          overflow: TextOverflow.ellipsis,
                          color: CustomColors.dark.withOpacity(.6)),
                    ),
                    // const SizedBox(height: 12),
                    Row(
                      children: [
                        CustomChip(label: plan.time!.format(context)),
                        const SizedBox(width: 8),
                        CustomChip(
                          label: plan.type ?? "",
                        ),
                        const SizedBox(width: 8),
                        CustomChip(
                          label: plan.subject,
                          // color: CustomColors.bgOverlay.withOpacity(.2),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}

class PlanSkelton extends StatelessWidget {
  const PlanSkelton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: CustomColors.bgOverlay,
      highlightColor: CustomColors.light.withOpacity(.4),
      child: Container(
        padding: const EdgeInsets.all(21),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            color: CustomColors.lightBgOverlay,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 180, height: 15, color: Colors.green),
                  const SizedBox(height: 5),
                  Container(width: 200, height: 10, color: Colors.grey),
                  Row(
                    children: const [
                      CustomChip(
                        label: "#home-work",
                      ),
                      SizedBox(width: 8),
                      CustomChip(
                        label: "#maths",
                        // color: CustomColors.bgOverlay.withOpacity(.2),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
