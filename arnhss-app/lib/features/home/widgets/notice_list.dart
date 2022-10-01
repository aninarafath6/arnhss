import 'package:arnhss/features/authentication/login/view/index.dart';
import 'package:arnhss/features/home/view_models/home_view_model.dart';

class NoticeList extends StatelessWidget {
  const NoticeList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 180,
      child: ListView.builder(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: context.read<HomeViewModel>().noticeList.length + 1,
        itemBuilder: (BuildContext context, index) {
          if (context.read<HomeViewModel>().noticeList.length != index) {
            if (index == 0) {
              return Row(
                children: [
                  const SizedBox(width: 21),
                  context.read<HomeViewModel>().noticeList[index],
                ],
              );
            } else {
              return Row(
                children: [
                  const SizedBox(width: 10),
                  context.read<HomeViewModel>().noticeList[index],
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
