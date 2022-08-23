import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.onTap,
  }) : super(key: key);
  final String title;
  final Function()? onTap;
  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(100),
      height: 55,
      decoration: BoxDecoration(
          color: const Color(0xfff1f5f9),
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: CustomTextTheme(context: context).headLine2().copyWith(
                fontWeight: FontWeight.w400,
                fontSize: context.getHeight(1.6),
              ),
        ),
        trailing: Icon(leadingIcon),
      ),
    );
  }
}
