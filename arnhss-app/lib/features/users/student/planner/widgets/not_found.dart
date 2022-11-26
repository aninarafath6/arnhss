import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';


class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
    this.imageURL,
    this.title,
    this.isBig = false,
  }) : super(key: key);
  final String? imageURL;
  final String? title;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        SizedBox(
          width: context.getWidth(75),
          child: Center(
            child: Image.asset(imageURL ?? Images.notFound),
          ),
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 3),
        Text(
          title ?? "No plans for this date",
          style: CustomTextTheme(context: context).paragraph(),
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
