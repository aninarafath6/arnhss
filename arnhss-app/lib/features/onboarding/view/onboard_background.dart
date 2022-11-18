import 'package:arnhss/features/authentication/login/view/index.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Image.asset(image),
      ),
    );
  }
}
