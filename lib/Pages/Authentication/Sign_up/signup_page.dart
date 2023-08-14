import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/heading_text.dart';
import '../../../Helper/Widget/password_test_filed.dart';
import '../../../Helper/Widget/text_button_widget.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Utils/app_asset.dart';
import '../../../utils/app_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool active = false;

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
                      controller.clearTextFieldOfSignUp();
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
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: height * 0.02),
                      decoration: BoxDecoration(
                        color: greyColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset(bgLoginPage),
                    ),
                    const SizedBox(height: 25),
                    HeadingText(text: 'Sign Up', color: blueColor),
                    const SizedBox(height: 25),
                    //TextField
                    CustomeTextField(
                      readOnly: false,
                      hintText: 'Enter Your Name',
                      textInputType: TextInputType.name,
                      controller: controller.nameOfSignUp,
                    ),
                    const SizedBox(height: 25),
                    CustomeTextField(
                      readOnly: false,
                      hintText: 'Enter Your Email',
                      textInputType: TextInputType.emailAddress,
                      icon: Icons.mail,
                      controller: controller.emailOfSignUp,
                    ),
                    const SizedBox(height: 25),
                    CustomeTextField(
                      readOnly: false,
                      hintText: 'Enter Your Mobile No',
                      textInputType: TextInputType.phone,
                      icon: Icons.phone_android,
                      controller: controller.mobileNoOfSignUp,
                    ),
                    const SizedBox(height: 25),
                    PasswordTextField(
                      text: 'Enter Your Password',
                      controller: controller.passwordOfSignUp,
                    ),
                    const SizedBox(height: 25),
                    PasswordTextField(
                      text: 'Confirm  Your Password',
                      controller: controller.confirmPasswordOfSignUp,
                    ),
                    const SizedBox(height: 25),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              active = !active;
                            });
                          },
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: active ? blueColor : whiteColor,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: blackColor.withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                              text: ' By continuing, you agree to the',
                              style: TextStyle(
                                color: blueColor.withOpacity(0.7),
                                letterSpacing: 0.5,
                                fontSize: 12,
                              ),
                              children: const [
                                TextSpan(
                                  text: ' Terms and Conditions.',
                                  style: TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.04),
                    TextButtonWidget(
                      text: 'Sign Up',
                      pres: () {
                        controller.userRegistration(context, active);
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
