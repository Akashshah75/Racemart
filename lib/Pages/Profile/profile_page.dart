import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Pages/User%20interst/update_user_interest_page.dart';
import '../../Provider/icon_change_provider.dart';
import '../../Provider/profile/profile_provider.dart';
import 'components/change_password_bottom_sheet.dart';
import 'components/profiel_bottom_sheet.dart';
import 'components/profiel_data_show_container.dart';
import 'components/profiel_edit_data_row_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final controller = Provider.of<ProfileProvider>(context, listen: false);
      controller.fetchProfileData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final iconProvider = Provider.of<IconChangeProvider>(context, listen: true);
    final controller = Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileDataShowContainer(
                      width: width,
                      data: controller.mapOfProfileData,
                    ),
                    const SizedBox(height: 110),
                    ProfileEditDataRowContainer(
                      title: 'Edit Profile',
                      press: () {
                        iconProvider.changeIcon(true);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          enableDrag: false,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          builder: (context) =>
                              ProfileBottomSheet(h: h, controller: controller),
                        );
                      },
                      icon: Icons.arrow_forward_ios_sharp,
                    ),
                    ProfileEditDataRowContainer(
                      title: 'Change Password',
                      icon: Icons.arrow_forward_ios_sharp,
                      press: () {
                        iconProvider.changeIcon(true);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          enableDrag: false,
                          context: context,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          builder: (context) => ChangePasswordBottomSheet(
                              h: h, controller: controller),
                        );
                      },
                    ),
                    //
                    ProfileEditDataRowContainer(
                      title: 'User Interests',
                      icon: Icons.arrow_forward_ios_sharp,
                      press: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                            child: const UpdateUserInterestPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
