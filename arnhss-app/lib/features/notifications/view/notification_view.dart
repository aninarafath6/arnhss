import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/notifications/widgets/notification_app_bar.dart';
import 'package:arnhss/features/notifications/widgets/notification_tile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notificationsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 15),
        child: ListView(
          children: const [
            NotificationTile(),
            NotificationTile(),
            NotificationTile(),
            NotificationTile(),
          ],
        ),
      ),
    );
  }
}
