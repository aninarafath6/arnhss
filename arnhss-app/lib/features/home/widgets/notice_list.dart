import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';
import 'package:arnhss/features/home/widgets/notice_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remixicon/remixicon.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _notices = Provider.of<QuerySnapshot?>(context);
    List<NoticeModel> notices = NoticeModel.listFromJson(_notices);

    return SizedBox(
      // width: 200,
      height: 180,
      child: ListView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: notices.length + 1,
        itemBuilder: (BuildContext context, index) {
          // return Container(
          //   margin: EdgeInsets.only(left: index == 0 ? 21 : 0),
          //   child: NoticeItem(notice: notice),
          // );
          if (notices.length != index) {
            if (index == 0) {
              return Row(
                children: [
                  const SizedBox(width: 21),
                  NoticeItem(notice: notices[0]),
                  // context.read<HomeViewModel>().noticeList[0],
                ],
              );
            } else {
              NoticeModel notice = notices[index];

              return Row(
                children: [
                  const SizedBox(width: 10),
                  NoticeItem(notice: notice),
                  // context.read<HomeViewModel>().noticeList[index],
                ],
              );
            }
          } else {
            return Row(
              children: [
                const SizedBox(width: 24),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_outlined),
                ),
                const SizedBox(width: 24),
              ],
            );
          }
        },
      ),
    );
  }
}
