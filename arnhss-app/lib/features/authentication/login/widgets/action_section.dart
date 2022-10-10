import 'package:arnhss/features/authentication/login/widgets/custom_button.dart';
import 'package:arnhss/features/authentication/login/widgets/custom_footer.dart';
import 'package:arnhss/features/authentication/login/view_model/login_view_model.dart';
import 'package:arnhss/common/widgets/custom_button.dart';
import 'package:arnhss/common/widgets/custom_modal.dart';
import 'package:arnhss/common/widgets/custom_snack_bar.dart';
import 'package:arnhss/features/authentication/login/widgets/input_box.dart';
import 'package:arnhss/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.spacing(height: 5),
        const InputFelid(),
        const SizedBox(height: 25),
        CustomButton(
          label: "Get OTP",
          onTap: () {
            if (context.read<LoginViewModel>().otpDialog()) {
              customModal(context);
            } else {
              customSnackBar(
                  content: "sorry 🙂, Please enter valid mobile number.");
            }

            // Navigator.pushNamed(context, OtpVerificationView.routeName);
          },
        ),
        const Spacer(),
        const TermsParagraph(),
      ],
    );
  }
}
