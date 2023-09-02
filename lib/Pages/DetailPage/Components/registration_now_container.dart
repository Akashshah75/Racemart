import 'package:flutter/material.dart';

import '../../../Utils/app_color.dart';
import '../../../Utils/constant.dart';

class RegisterNowContainer extends StatelessWidget {
  const RegisterNowContainer({
    super.key,
    required this.registrationUrl,
  });
  final String registrationUrl;

  @override
  Widget build(BuildContext context) {
    print('registrationUrl:$registrationUrl');
    final Uri url = Uri.parse(registrationUrl);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const Divider(),
        registrationUrl.isEmpty
            ? const SizedBox()
            : Positioned(
                top: -33,
                right: 10,
                child: Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: appRed, //blueColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                    ),
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: TextButton(
                        onPressed: () {
                          // print('my');
                          // print('ok');
                          launchUrls(url);
                          // launchUrl(url);
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

//
