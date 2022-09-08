import 'package:arnhss/common/constants/color_constants.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    this.index,
    this.image = "assets/images/icons/design-badge.png.webp",
    this.label = "label",
    this.isSmall = true,
    this.count = 0,
    this.onTap,
  }) : super(key: key);
  final int? index;
  final String? image;
  final String? label;
  final bool? isSmall;
  final int? count;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 10, bottom: isSmall! ? 10 : 0, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: CustomColors.lightBgOverlay,
            ),
            child: Center(
              child: Column(
                verticalDirection:
                    isSmall! ? VerticalDirection.down : VerticalDirection.up,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Spacer(flex: 3),
                  Expanded(
                    child: Image.asset(
                      image!,
                      width: isSmall! ? 100 : 300,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment:
                        isSmall! ? Alignment.bottomCenter : Alignment.topLeft,
                    child: Text(
                      label!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
            ),
          ),
          count! == 0
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.orange.withOpacity(.2),
                      child: Center(
                        child: Text(
                          count! == 0 ? "" : count!.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ),
                    ),
                    // top: isSmall! ? 10 : 10,
                    // right: isSmall! ? 10 : 10,
                    alignment:
                        !isSmall! ? Alignment.topRight : Alignment.topLeft,
                  ),
                ),
        ],
      ),
    );
  }
}
