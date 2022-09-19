import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_input.dart';
import 'package:arnhss/common/widgets/custom_selector.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:remixicon/remixicon.dart';

void showAddPlanForm(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: ((context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: context.getHeight(65),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: CustomColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CustomColors.light),
                      ),
                    ),
                  ),
                  const Text(
                    "Add Plan",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: CustomColors.dark),
                  ),
                  const Text(
                    "Add Plan",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.transparent),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 5),
              const CustomInput(hintText: " Task title"),
              const CustomInput(hintText: "Enter your title", large: true),
              Row(
                children: const [
                  Expanded(
                    child: CustomSelector(),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomSelector(icon: Remix.time_line),
                  ),
                ],
              ),
              const Spacer(),
              const CustomButton(),
            ],
          ),
        ),
      );
    }),
  );
}
