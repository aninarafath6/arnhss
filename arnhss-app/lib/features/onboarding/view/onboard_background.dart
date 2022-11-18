import 'package:arnhss/features/authentication/login/view/index.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.image,
    this.size = 100,
    this.padding = 50,
  }) : super(key: key);

  final String image;
  final double size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: context.isMobile ? 30 : 0),
      // height: context.getHeight(size),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Align(
          child: Image.asset(
            image,
            width: context.getHeight(size),
          ),
          alignment:
              context.isMobile ? Alignment.bottomCenter : Alignment.center,
        ),
      ),
    );
  }
}
