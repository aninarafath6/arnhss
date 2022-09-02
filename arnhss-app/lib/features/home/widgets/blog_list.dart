import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/home/view_models/home_view_mdoel.dart';
import 'package:arnhss/features/home/widgets/blog_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogList extends StatelessWidget {
  const BlogList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: List.generate(
          context.read<HomeViewModel>().blogList.length + 1,
          (index) {
            if (index == 0) {
              return Column(
                children: const [_Header(), SizedBox(height: 20)],
              );
            } else {
              return BlogItem(
                blog: context.read<HomeViewModel>().blogList[index - 1],
              );
            }
          },
        ),
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
              .copyWith(fontSize: 14, color: Colors.purple),
        ),
      ],
    );
  }
}
