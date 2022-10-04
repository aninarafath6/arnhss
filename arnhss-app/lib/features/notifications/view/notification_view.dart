import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _notificationsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 15),
        child: ListView(
          children: <Widget>[
            Dismissible(
              key: const ValueKey(1),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: const Text("Sunday is holiday"),
                  subtitle: const Text("Something went sunday is holyday."),
                  leading: CircleAvatar(
                    backgroundColor: CustomColors.lightBgOverlay,
                    child: const Center(
                      child: Icon(
                        Remix.bell_line,
                        size: 18,
                        color: CustomColors.light,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _notificationsAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
