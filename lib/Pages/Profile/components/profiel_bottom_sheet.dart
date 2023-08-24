import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Utils/app_color.dart';

import '../../../Helper/Widget/custome_app_bar_widget.dart';
import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/text_button_widget.dart';
import '../../../Provider/profile/profile_provider.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet(
      {super.key, required this.h, required this.controller});
  final double h;
  final ProfileProvider controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          final data = value.mapOfProfileData;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomeAppBarWidget(
                title: 'Edit Profile',
                controller: controller,
              ),
              const Divider(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 120,
                    child: TextButton(
                        onPressed: () {
                          controller.activeProfileEditeMode();
                        },
                        child: value.isEdite
                            ? const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'cancel Edit',
                                    style: TextStyle(color: redColor),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.cancel,
                                    size: 16,
                                    color: redColor,
                                  ),
                                ],
                              )
                            : const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Edit'),
                                  SizedBox(width: 10),
                                  Icon(Icons.edit, size: 16),
                                ],
                              )),
                  ),
                ),
              ),
              // Consumer<ProfileProvider>(
              //   builder: (context, value, child) {
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                    image: value.selectedImage != null
                        ? DecorationImage(
                            image: FileImage(
                              value.selectedImage!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: NetworkImage(data['profile']),
                            fit: BoxFit.cover,
                          )
                    //  const DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: AssetImage(noImageProfile),
                    //   ),
                    ),
              ),
              // },
              // ),
              //
              const SizedBox(height: 10),
              value.isEdite
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.pickImage(ImageSource.gallery);
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo),
                                SizedBox(width: 10),
                                Text('Pick Gallery'),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.pickImage(ImageSource.camera);
                          },
                          child: const SizedBox(
                            width: 150,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                SizedBox(width: 10),
                                Text('Pick Camera'),
                              ],
                            ),
                          ),
                        ),
                        // Container(),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 5),
              CustomeTextField(
                readOnly: value.isEdite ? false : true,
                hintText: value.isEdite ? 'Name' : data['name'] ?? '',
                controller: controller.name,
                textInputType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomeTextField(
                readOnly: value.isEdite ? false : true,
                hintText: value.isEdite ? 'Email' : data['email'] ?? "",
                icon: Icons.email,
                textInputType: TextInputType.emailAddress,
                controller: controller.email,
              ),
              const SizedBox(height: 10),
              CustomeTextField(
                readOnly: value.isEdite ? false : true,
                hintText: value.isEdite ? 'Mobile no' : data['mobile'] ?? '',
                icon: Icons.phone_android,
                textInputType: TextInputType.number,
                controller: controller.mobileNo,
              ),
              const SizedBox(height: 10),
              //
              const SizedBox(height: 15),
              TextButtonWidget(
                text: 'Submit',
                isLoading: controller.updateProfile,
                pres: () {
                  controller.updateProfileByMultiportData(
                    context,
                    selectedName: data['name'],
                    selectedEmail: data['email'],
                    selecetdMobile: data['mobile'],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
