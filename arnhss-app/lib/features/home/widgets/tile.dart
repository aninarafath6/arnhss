import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    this.index,
    this.image = "assets/images/icons/design-badge.png.webp",
    this.label = "label",
    this.isSmall = true,
  }) : super(key: key);
  final int? index;
  final String? image;
  final String? label;
  final bool? isSmall;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
            top: 10, bottom: isSmall! ? 10 : 0, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.grey.withOpacity(.1),
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
    );
  }
}
