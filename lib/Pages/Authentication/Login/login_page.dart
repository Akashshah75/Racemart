import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:racemart_app/Provider/Home%20providers/home_page_provider.dart';

import '../../../Helper/Widget/custome_textfield.dart';
import '../../../Helper/Widget/heading_text.dart';
import '../../../Helper/Widget/password_test_filed.dart';
import '../../../Helper/Widget/text_button_widget.dart';
import '../../../Helper/Widget/text_widget.dart';
import '../../../Provider/authentication_provider.dart';
import '../../../Routes/route_names.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      provider.getCurrentPosition(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<AuthenticationProvider>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                left: -80,
                top: -80,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset(bgSignPage),
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
                        color: containerColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: SvgPicture.asset(bgLoginPage),
                    ),
                    //Text
                    const SizedBox(height: 25),
                    HeadingText(text: 'Login', color: blueColor),
                    const SizedBox(height: 25),
                    //TextField
                    CustomeTextField(
                      readOnly: false,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter Your Name',
                      controller: controller.emailOfLogin,
                      iconColor: blueColor,
                    ),
                    const SizedBox(height: 25),
                    PasswordTextField(
                      text: 'Enter Your Password',
                      controller: controller.passwordOfLogin,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.forgetPasswordPage);
                            // print('ok');
                          },
                          child: const TextWidget(
                            text: 'Forget Password?',
                            fontSize: 12,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // controller.isLoading == true
                    //     ? const Center(
                    //         child: Text('Loading...'),
                    //       )
                    //     :
                    TextButtonWidget(
                      text: 'Login',
                      isLoading: controller.isLoading,
                      pres: () {
                        controller.login(context);
                        // Navigator.pushNamed(context, RouteNames.homePage);
                      },
                    ),
                    SizedBox(height: height * 0.2),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.signUpPage);
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'No account yet?',
                            style: const TextStyle(
                              color: greyColor,
                              letterSpacing: 1.2,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign Up ',
                                style: TextStyle(
                                  color: blueColor,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const TextSpan(text: 'now!'),
                            ]),
                      ),
                    )
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
