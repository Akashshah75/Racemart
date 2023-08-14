import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/heading_text.dart';
import '../../../Helper/Widget/text_button_widget.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<AuthenticationProvider>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 0,
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: greyColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    color: blueColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    //App logo
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: height * 0.12),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset(bgLoginPage),
                    ),
                    //Text
                    const SizedBox(height: 25),
                    HeadingText(text: 'Forget Password', color: blueColor),
                    const SizedBox(height: 25),
                    CustomeTextField(
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter Your Email',
                      icon: Icons.mail,
                      iconColor: blueColor,
                      controller: controller.emailOfForgetPassword,
                    ),
                    const SizedBox(height: 25),
                    TextButtonWidget(
                      text: 'Send Link',
                      pres: () {
                        controller.forgetPassword(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
