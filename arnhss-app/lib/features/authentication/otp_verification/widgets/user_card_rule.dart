import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class UserRuleCard extends StatelessWidget {
  const UserRuleCard({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: AppSizes.defualt_padding - 15,
      ),
      height: context.getHeight(7),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          AppSizes.defualt_border_raidus + 2,
        ),
      ),
      child: Center(
        child: ListTile(
          title: Text(title),
          onTap: onTap,
          // leading: Icon(),
          leading: Image.asset(
            icon,
            height: 50,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
