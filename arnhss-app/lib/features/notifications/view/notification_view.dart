import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:flutter/services.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(color: CustomColors.dark),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            splashRadius: 28,
            icon: const Icon(Icons.arrow_back_ios, color: CustomColors.dark)),
      ),
      body: const Center(
        child: Text("this is notification view"),
      ),
    );
  }
}
