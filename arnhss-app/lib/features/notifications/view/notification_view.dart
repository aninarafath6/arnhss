import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/notifications/view_model/notification_view_model.dart';
import 'package:arnhss/features/notifications/widgets/notification_app_bar.dart';
import 'package:arnhss/features/notifications/widgets/notification_tile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    int _notificationCount =
        context.watch<NotificationViewModel>().notificationCount;
    return Scaffold(
      appBar: notificationsAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.default_padding - 15, vertical: 10),
        child: _notificationCount == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      Images.notificationNotFound,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "You're all caught up",
                    style: CustomTextTheme(context: context)
                        .paragraph()
                        .copyWith(color: CustomColors.dark.withOpacity(.8)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "This is where you'all see notifications about your\narnhss account",
                    style: CustomTextTheme(context: context)
                        .paragraph()
                        .copyWith(fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  var _notification = context
                      .watch<NotificationViewModel>()
                      .notifications[index];
                  return NotificationTile(
                    notification: _notification,
                    onDismiss: (_) {
                      return context
                          .read<NotificationViewModel>()
                          .dismissNotification(_notification.id!);
                    },
                  );
                },
                itemCount: _notificationCount,
              ),
      ),
    );
  }
}
