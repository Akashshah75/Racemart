import 'package:flutter/material.dart';

import '../../../Utils/app_asset.dart';
import '../../../Utils/app_color.dart';

class ProfileDataShowContainer extends StatelessWidget {
  const ProfileDataShowContainer({
    super.key,
    required this.width,
    this.data,
  });
  final double width;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(
            color: whiteColor,
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                // blueColor.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: blackColor,
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
        //
        Positioned(
          top: 40,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              height: 200,
              width: width * 0.95,
              child: Card(
                elevation: 1,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: greyColor.withOpacity(0.8),
                          ),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(noImageProfile),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      data['name'] ?? "Akash Shah",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: blackColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['email'] ?? "shahakash@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
