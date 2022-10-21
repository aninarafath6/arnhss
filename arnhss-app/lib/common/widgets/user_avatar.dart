import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/enums.dart';
import 'package:arnhss/models/user.model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    Key? key,
    required this.user,
    this.radius = 25,
  }) : super(key: key);

  final UserModel? user;
  final double radius;

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: CustomColors.bgOverlay,
      child: widget.user?.dpURL == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(offlineDP(widget.user?.gender ?? Gender.male)),
            )
          : ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.user!.dpURL!,
                width: 100,
                height: 100,
                placeholder: ((context, url) => Center(
                      child: Text(
                        " ${widget.user?.name?.split(" ")[0].split("")[0]}${widget.user?.name?.split(" ")[1].split("")[0]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.dark.withOpacity(.5),
                        ),
                      ),
                    )),
                cacheKey: widget.user?.id,
                errorWidget: ((context, url, error) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        offlineDP(widget.user?.gender ?? Gender.male)),
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
