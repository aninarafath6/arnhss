import 'package:arnhss/features/authentication/login/view/index.dart';

import 'package:arnhss/features/home/model/notice_model.dart';
import 'package:arnhss/features/home/widgets/notice_item.dart';
import 'package:remixicon/remixicon.dart';

class HomeViewModel with ChangeNotifier {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final List<NoticeItem> noticeList = [
    NoticeItem(
      notice: NoticeModel(
        date: "01 March 2022",
        icon: Remix.notification_line,
        title: "HSS Reporter Updates",
        description:
            "HSS Reporter Updates\n \n🎯 Plus One Improvement Exam from 25th to 29th October.\n\n🎯A child can improv up to maximum 3 subjects.\n\n🎯 Children can pay the examination fee to the school till 05-09-2022.\n\n🎯 Students who have been given First Year\nRevaluation need to pay the fee for Imp Exam within three days after the revaluation result\n\nwww.hssreporter.com",
      ),
    ),
    NoticeItem(
      notice: NoticeModel(
        date: "01 March 2022",
        icon: Remix.user_6_line,
        title: 'PTA meeting',
        subDescription:
            "(Write the answer letter given below and submit it to the class teacher with the signature of the parents)\n\nNotice of parent meeting to be held on 01.09.2022 has been received. He knows that he will come to the meeting.\nParent's Signature:\nName:\nStudent Name:\nClass studied:",
        description:
            "Dear Parents,\nPlus one\nA meeting of the parents of Plus Two students is being held on Thursday 01.09.2022 at 2 pm in the Higher Secondary Auditorium in order to evaluate the result of the general examination and similarly to evaluate the result of the unit test and to directly assess the learning progress of the teachers' children. Your presence is requested in the said meeting.\nRegards,\nDr. C. Anas\nPrincipal\n29.08.2022.",
      ),
    ),
    NoticeItem(
      notice: NoticeModel(
          icon: Remix.patreon_line,
          title: "Everyone Bring the fee tomorrow",
          description:
              "Everyone bring the fee tomorrow. It will be difficult to collect the fee as the program will be held on the next day.",
          date: "01 March 2022",
          subDescription:
              " Examination fees for children taking the 1st Year Higher Secondary Improvement Examination are also due tomorrow (1/9/22, 2/9/22) at school. Documents to be submitted to the school 1. Application Form 2.+1 Marklist Copy fee Paper 1 N 175 + 40 A child can write maximum 3 papers"),
    ),
  ];
}
