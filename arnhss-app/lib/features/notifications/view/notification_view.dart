import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("this is notification view"),
    ));
  }
}
