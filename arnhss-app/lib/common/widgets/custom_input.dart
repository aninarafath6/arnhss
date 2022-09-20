import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({Key? key, this.hintText, this.large = false})
      : super(key: key);

  final String? hintText;
  final bool? large;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(bottom: 10),
      height: large! ? 150 : 50,
      decoration: BoxDecoration(
        color: CustomColors.bgOverlay,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: large! ? 5 : 1,
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
