import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/models/student.model.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class StudentAvatar extends StatefulWidget {
  const StudentAvatar({
    Key? key,
    required this.student,
    this.radius = 25,
  }) : super(key: key);

  final StudentModel student;
  final double radius;

  @override
  State<StudentAvatar> createState() => _StudentAvatarState();
}

class _StudentAvatarState extends State<StudentAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: CustomColors.bgOverlay,
      child: widget.student.dpURL == null
          ? Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset(offlineDP(widget.student.gender)),
            )
          : ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.student.dpURL!,
                key: ValueKey(widget.student.id),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: ((context, url) {
                  List<String>? nameList = widget.student.name.split(" ");
                  return Center(
                    child: Text(
                      " ${nameList[0].split("")[0]}${nameList.length > 1 ? nameList[0].split("")[0] : ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CustomColors.dark.withOpacity(.5),
                      ),
                    ),
                  );
                }),
                cacheKey: widget.student.id.toString(),
                errorWidget: ((context, url, error) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Image.asset(
                      offlineDP(Gender.male),
                    ),
                  );
                }),
              ),
            ),
    );
  }

  String offlineDP(Gender gender) {
    if (gender == Gender.male) {
      return Images.maleStudentRoleIcon;
    } else {
      return Images.femaleStudentRoleIcon;
    }
  }
}
