import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/home/model/blog_model.dart';
import 'package:flutter/material.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({
    Key? key,
    required this.blog,
  }) : super(key: key);
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: CustomColors.dark,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  blog.displayImage ??
                      "https://collegemarker.com/blogs/wp-content/uploads/2022/02/secondary-school-student.jpg",
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextTheme(context: context)
                        .headLine2()
                        .copyWith(fontSize: 15),
                  ),
                  // const SizedBox(height: 5),
                  // Text(
                  //     "Ideation is a creative process where designersgenerate ideas in sessions (e.g. brainstorming",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 12,
                  //       color: Colors.grey[600],
                  //     ),
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 15),
                  Row(
                    // mainAxisAlignment:
                    // MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(blog.avatar ??
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg/1200px-Elon_Musk_Royal_Society_%28crop2%29.jpg"),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        blog.user!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      // Spacer(),
                      const SizedBox(width: 15),
                      Icon(Icons.circle, size: 8, color: Colors.grey[600]),
                      const SizedBox(width: 8),

                      Text(
                        blog.time ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
