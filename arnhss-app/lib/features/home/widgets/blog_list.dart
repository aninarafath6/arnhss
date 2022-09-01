import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/home/widgets/blog_item.dart';
import 'package:flutter/material.dart';

class BlogList extends StatelessWidget {
  const BlogList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const [
          _Header(),
          SizedBox(height: 20),
          BlogItem(),
          BlogItem(),
          BlogItem(),
          BlogItem(),
          BlogItem(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Jst For You",
          style: CustomTextTheme(context: context)
              .headLine()
              .copyWith(fontSize: 20),
        ),
        const Spacer(),
        Text(
          "View all",
          style: CustomTextTheme(context: context)
              .paragraph()
              .copyWith(fontSize: 14, color: Colors.blue),
        ),
      ],
    );
  }
}
