import 'package:arnhss/abstract/loader.abstract.dart';
import 'package:arnhss/common/constants/app_sizes.dart';
import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/widgets/custom_loading.dart';
import 'package:arnhss/common/widgets/not_found.dart';
import 'package:arnhss/extensions/string_extension.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:arnhss/features/users/admin/admission/model/course_model.dart';
import 'package:arnhss/features/users/admin/admission/view_model/admission_view_model.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shimmer/shimmer.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({Key? key}) : super(key: key);
  static const String routeName = "/admin_dashboard";

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AdmissionViewModel>().getCourses();
      //... others are same
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Courses"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.default_padding,
          vertical: 10,
        ),
        child: Consumer<AdmissionViewModel>(
          builder: (context, value, _) {
            return value.loading
                ? ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        const CourseCard(isSkelton: true),
                  )
                : value.courseCount == 0
                    ? const NotFound(
                        imageURL: "assets/images/icons/spot-workflow.png.webp",
                        title:
                            "Unfortunately, no courses have been found\nfor this time",
                      )
                    : ListView.builder(
                        itemCount: value.courseCount,
                        itemBuilder: (BuildContext context, index) {
                          Course course = value.courses[index];
                          return CourseCard(course: course);
                        },
                      );
          },
        ),
      ),
      floatingActionButton: TextButton(
        onPressed: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: CustomColors.dark,
          ),
          child: const Icon(Remix.add_fill, color: Colors.white),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    this.course,
    this.isSkelton = false,
  }) : super(key: key);

  final Course? course;
  final bool isSkelton;

  @override
  Widget build(BuildContext context) {
    if (isSkelton) {
      return Shimmer.fromColors(
        baseColor: CustomColors.bgOverlay,
        highlightColor: CustomColors.light.withOpacity(.5),
        child: ListTile(
          title: Container(
            width: context.getWidth(80),
            color: Colors.black,
            height: 12,
          ),
          subtitle: Container(
            width: context.getWidth(80),
            color: Colors.black,
            height: 8,
            margin: const EdgeInsets.only(bottom: 4),
          ),
          leading: CircleAvatar(
            backgroundColor: CustomColors.bgOverlay,
            child: Text(course?.d_code ?? ""),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      );
    } else {
      return ListTile(
        title: Text(course?.name ?? ""),
        subtitle: Text("Course code : ${course?.code}"),
        leading: CircleAvatar(
          backgroundColor: CustomColors.bgOverlay,
          child: Text(course?.d_code ?? ''),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      );
    }
  }
}
