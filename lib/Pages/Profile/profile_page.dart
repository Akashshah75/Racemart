import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/icon_change_provider.dart';
import '../../Provider/profile/profile_provider.dart';
import '../../Utils/app_asset.dart';
import '../../Utils/app_color.dart';
import 'components/change_password_bottom_sheet.dart';
import 'components/profiel_bottom_sheet.dart';
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
    final profileData = controller.mapOfProfileData;
    // print(width * 2);
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: h * 0.72,
                      width: width,
                      decoration: BoxDecoration(
                        color: redColor,
                        image: profileData['profile'] != null
                            ? DecorationImage(
                                image: NetworkImage(profileData['profile']),
                                fit: BoxFit.cover,
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(noImageProfile),
                              ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appBg,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: blackColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 50),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                  color: blackColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: h * 0.35,
                      width: width,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                        ),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            profileData['name'] ?? " ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1.2,
                              color: blackColor.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            profileData['email'] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1,
                              color: textColor,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 15),
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
                                builder: (context) => ProfileBottomSheet(
                                    h: h, controller: controller),
                              );
                            },
                            icon: Icons.arrow_forward_ios_sharp,
                          ),
                          const SizedBox(height: 10),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
