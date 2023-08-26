import 'package:flutter/material.dart';

import '../../../../Utils/app_color.dart';
import '../../../../Utils/app_size.dart';

class HowToREachContainer extends StatelessWidget {
  const HowToREachContainer({
    super.key,
    this.data,
  });
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: white,
      ),
      child: data['address'] == null
          ? const Center(
              child: Text("No date specify!!!"),
            )
          : Padding(
              padding: defaultSymetricPeding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text(
                      'How To Reach ?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: redColor,
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: blackColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        //
                        const Divider(),
                        Text(
                          data['address'] ?? '...',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: greyColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                        // const SizedBox(height: 10),
                        // const Divider(),
                        // const Row(
                        //   children: [
                        //     SocialMediaIconContainer(icon: Icons.g_mobiledata),
                        //     SizedBox(width: 8),
                        //     SocialMediaIconContainer(icon: Icons.facebook),
                        //     SizedBox(width: 8),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}

class SocialMediaIconContainer extends StatelessWidget {
  const SocialMediaIconContainer({
    super.key,
    required this.icon,
    this.width = 35,
    this.height = 35,
    this.iconsize = 18,
  });

  final IconData icon;
  final double width, height, iconsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: redColor,
      ),
      child: Icon(
        icon,
        color: whiteColor,
        size: iconsize,
      ),
    );
  }
}
