import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(
          child: InkWell(
            child: Container(
              // width: 100,
              // height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(26),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.purple],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Center(
                child: Row(
                  children: const [
                    // SizedBox(width: 8),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://aninarafath.me/images/about-1.jpeg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
