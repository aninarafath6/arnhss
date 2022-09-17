import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/login/view/index.dart';
// import 'package:remixicon/remixicon.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, this.isSkelton = false}) : super(key: key);

  final bool isSkelton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: CustomColors.lightBgOverlay,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isSkelton
                    ? Container(width: 180, height: 15, color: Colors.green)
                    : const Text(
                        "Home works on maths",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                const SizedBox(height: 5),
                isSkelton
                    ? Container(width: 200, height: 10, color: Colors.green)
                    : Text(
                        "Lorem ipsume text is used for desgining purpose",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis,
                            color: CustomColors.dark.withOpacity(.6)),
                      ),
                Row(
                  children: [
                    Chip(
                      label: const Text(
                        "#home-work",
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.orange.withOpacity(.2),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text(
                        "#home-work",
                        style: TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.orange.withOpacity(.2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}

// class _TaskTime extends StatelessWidget {
//   const _TaskTime({
//     Key? key,
//     required this.time,
//   }) : super(key: key);
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       time,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 13,
//         color: CustomColors.dark.withOpacity(.6),
//       ),
//     );
//   }
// }
