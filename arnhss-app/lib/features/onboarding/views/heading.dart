import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Text(
        "Ar Nagar Hss- A complete educational institute",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
