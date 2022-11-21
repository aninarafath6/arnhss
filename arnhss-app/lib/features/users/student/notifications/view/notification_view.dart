import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/constants/image_constant.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/student/notifications/view_model/notification_view_model.dart';
import 'package:arnhss/features/users/student/notifications/widgets/notification_app_bar.dart';
import 'package:arnhss/features/users/student/notifications/widgets/notification_tile.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    debugPrint("Notification build");

    int _notificationCount =
        context.watch<NotificationViewModel>().notificationCount;
    return Scaffold(
      appBar: notificationsAppBar(context),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.default_padding - 15, vertical: 10),
          child: _notificationCount == 0
              ? const NotFound(
                  title: "You're all caught up",
                  subTitle:
                      "This is where you'all see notifications about your\narnhss account",
                  imageURL: Images.notificationNotFound,
                )
              : const NotificationList(),
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _notificationCount =
        context.watch<NotificationViewModel>().notificationCount;
    return ListView.builder(
      itemBuilder: (context, index) {
        var _notification =
            context.watch<NotificationViewModel>().notifications[index];
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
    );
  }
}
