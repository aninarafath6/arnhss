import 'package:arnhss/features/authentication/login/view/index.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      height: context.getHeight(100),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Align(
          child: Image.asset(image),
          alignment:
              context.isMobile ? Alignment.bottomCenter : Alignment.center,
        ),
      ),
    );
  }
}
