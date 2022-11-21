import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.hintText,
    this.size = Sizing.sm,
    this.controller,
  }) : super(key: key);

  final String? hintText;
  final Sizing size;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      height: size == Sizing.xl
          ? 500
          : size == Sizing.lg
              ? 150
              : 50,
      decoration: BoxDecoration(
        color: CustomColors.bgOverlay,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: size == Sizing.xl
            ? 20
            : size == Sizing.lg
                ? 5
                : 1,
        // maxLines: null,
        keyboardType: TextInputType.multiline,
        controller: controller,
        minLines: 1,
        cursorColor: CustomColors.dark,
        style: Theme.of(context).textTheme.subtitle1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "",
          hintStyle: CustomTextTheme(context: context).paragraph(),
        ),
      ),
    );
  }
}

enum Sizing {
  sm,
  lg,
  xl,
}
