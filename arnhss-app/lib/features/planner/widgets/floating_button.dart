import 'package:arnhss/common/constants/color_constants.dart';
import 'package:remixicon/remixicon.dart';

import '../../authentication/otp_verification/view/index.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: TextButton(
        onPressed: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CustomColors.dark,
          ),
          child: const Icon(Remix.add_fill, color: Colors.white),
        ),
      ),
    );
  }
}
