import 'package:arnhss/common/theme/text_theme.dart';

import '../../../../authentication/otp_verification/view/index.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      // height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 30,
            color: Color.fromARGB(11, 37, 37, 37),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 14),
              const Text(
                "Elone musk",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                "yesterday",
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.grey[600]),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Text(
            "10 Habits of Highly Effective Students",
            style: CustomTextTheme(context: context)
                .headLine()
                .copyWith(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            "The key to becoming an effective student is learning how to study smarter, not harder. This becomes more and more true as you advance in your education. An hour or two of studying a day is usually sufficient to make it through high school with satisfactory grades, but when college arrives, there aren't enough hours in the day to get all your studying in if you don't know how to study smarter.",
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: CustomTextTheme(context: context).paragraph(),
          ),
          const SizedBox(height: 12),
          const CustomButton(
            label: "Read more",
          )
        ],
      ),
    );
  }
}
