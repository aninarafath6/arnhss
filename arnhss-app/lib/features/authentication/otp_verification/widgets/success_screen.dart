
  import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:lottie/lottie.dart';

Future<dynamic> SuccessScreen(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Lottie.asset(
                        "assets/lottie/lf30_editor_tsoh2riw.json",
                        fit: BoxFit.contain,
                        width: context.getWidth(60),
                        repeat: false,
                      ),
                    ),
                    Text(
                      "Welcome to ARNHSS",
                      style: CustomTextTheme(context: context)
                          .headLine()
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      "Your mobile number Authentication is successful",
                      style: CustomTextTheme(context: context)
                          .paragraph()
                          .copyWith(color: Colors.grey[200]),
                    )
                  ],
                ),
                Lottie.asset("assets/lottie/85744-success.json",
                    repeat: false, fit: BoxFit.contain),
              ],
            );
          },
        );
  
}
