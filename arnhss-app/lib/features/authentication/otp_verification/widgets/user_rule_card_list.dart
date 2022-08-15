import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';

class UserCardList extends StatelessWidget {
  const UserCardList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.defualt_padding + 2),
      height: context.getHeight(40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Text(
            "Select Your Role",
            style: CustomTextTheme(context: context)
                .headLine()
                .copyWith(fontSize: 20),
          ),
          context.spacing(height: 3),
          const UserRuleCard(title: "Student", icon: Images.studentRoleIcon),
          const UserRuleCard(title: "Student", icon: Images.studentRoleIcon),
        ],
      ),
    );
  }
}

class UserRuleCard extends StatelessWidget {
  const UserRuleCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final String title;
  final String icon;

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
          AppSizes.defualt_border_raidus,
        ),
      ),
      child: Center(
        child: ListTile(
          title: Text(title),
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
