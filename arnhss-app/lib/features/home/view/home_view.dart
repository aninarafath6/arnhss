import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/features/authentication/otp_verification/view/index.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 72,
        elevation: 0,
        actions: const [UserAvatar()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            Text(
              "Hey,",
              style: GoogleFonts.firaSans(
                fontSize: 28,
                color: CustomColors.dark,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Anin Arafath 👋🏻",
              style: GoogleFonts.firaSans(
                fontSize: 32,
                color: CustomColors.dark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
            child: InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.purple],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 21,
                    backgroundImage: NetworkImage(
                        "https://media-exp1.licdn.com/dms/image/C4D03AQF9epYnUdO4Bw/profile-displayphoto-shrink_200_200/0/1657266713987?e=2147483647&v=beta&t=Lgsc7nKjjMI1vXuzqOkQbpq2iLZoyaJpUZaIbGCe8cQ"),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
