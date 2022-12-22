import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.hintText,
    this.size = Sizing.sm,
    this.controller,
    this.keyboardType = TextInputType.multiline,
  }) : super(key: key);

  final String? hintText;
  final Sizing size;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 500, minHeight: size == Sizing.sm ? 50 : 200),
      width: context.getWidth(100),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      // height: size == Sizing.xl
      //     ? 500
      //     : size == Sizing.lg
      //         ? 150
      //         : 50,
      decoration: BoxDecoration(
        color: CustomColors.bgOverlay,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        keyboardType: keyboardType,
        maxLines: size == Sizing.xl
            ? 20
            : size == Sizing.lg
                ? 5
                : 1,
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

class InputPlaceholder extends StatelessWidget {
  const InputPlaceholder({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: context.getWidth(100),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: CustomColors.bgOverlay,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: CustomTextTheme(context: context).paragraph(),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down)
          ],
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
