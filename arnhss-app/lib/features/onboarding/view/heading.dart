import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 0 : 0),
      child: Text(
        "Ar Nagar Hss- A complete educational institute",
        textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
        style: // line aligner
            CustomTextTheme(context: context)
                .headLine()
                .copyWith(fontSize: context.isMobile ? 25 : 25),
      ),
    );
  }
}
