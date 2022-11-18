import 'package:arnhss/features/authentication/login/view/index.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.image, this.size = 100})
      : super(key: key);

  final String image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.isMobile ? 30 : 0),
      height: context.getHeight(size),
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
