import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.isMobile ? 0 : 5),
      child: Text(
        "An Interface to share the Creative Works and Others By Ar Nagar Hss Students and Teachers.  A Small Innovation By COMPUTER⚡SCIENCE ${context.isMobile ? "\n" : ""}2021-23.",
        style: CustomTextTheme(context: context)
            .paragraph()
            .copyWith(fontSize: context.isMobile ? context.getHeight(1.7) : 13),
        textAlign: context.isMobile ? TextAlign.center : TextAlign.start,
      ),
    );
  }
}
