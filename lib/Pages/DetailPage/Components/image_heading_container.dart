import 'package:flutter/material.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/app_asset.dart';
import '../../../Utils/constant.dart';

class ImageHedingContainer extends StatelessWidget {
  const ImageHedingContainer({
    super.key,
    required this.image,
    required this.title,
    required this.shareUrl,
    required this.registrationUrl,
    required this.earlyStartDate,
    required this.earlyEndDate,
  });
  final String image;
  final String title;
  final String shareUrl;
  final String registrationUrl;
  final String earlyStartDate;
  final String earlyEndDate;

  @override
  Widget build(BuildContext context) {
    // final Uri url = Uri.parse(registrationUrl);
    return Hero(
      tag: title,
      transitionOnUserGestures: true,
      child: Stack(
        children: [
          Container(
            foregroundDecoration: earlyStartDate.isEmpty || earlyEndDate.isEmpty
                ? const BoxDecoration()
                : checkDate(earlyStartDate, earlyEndDate)
                    ? const RotatedCornerDecoration.withColor(
                        color: redColor, // Colors.blue,
                        badgeSize: Size(64, 64),
                        badgePosition: BadgePosition.topStart,
                        textSpan: TextSpan(
                          text: 'Early\n bird',
                          style: TextStyle(fontSize: 10),
                        ),
                      )
                    : const BoxDecoration(),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            width: double.infinity,
            height: 200,
            decoration: image != demo
                ? BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: blackColor.withOpacity(0.2)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(demo),
                    ),
                  ),
            // child: Padding(
            //   padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       CustomeIconContainer(
            //           icon: Icons.arrow_back,
            //           press: () {
            //             Navigator.of(context).pop();
            //           }),
            //       Row(
            //         children: [
            //           CustomeIconContainer(
            //               icon: Icons.share,
            //               press: () async {
            //                 var urlImage =
            //                     image; //widget.data['poster']; //urlImage1;
            //                 final Uri url = Uri.parse(urlImage);
            //                 final res = await http.get(url);
            //                 final bytes = res.bodyBytes;
            //                 final temp = await getTemporaryDirectory();
            //                 final path = '${temp.path}/image.jpg';
            //                 File(path).writeAsBytesSync(bytes);
            //                 // ignore: deprecated_member_use
            //                 await Share.shareFiles([path], text: shareUrl);
            //               }),
            //         ],
            //       ),
            //     ],
            //   ),
          ),
          // );
          //
          // registrationUrl.isNotEmpty
          //     ? Positioned(
          //         bottom: 10,
          //         right: 10,
          //         child: Container(
          //           alignment: Alignment.center,
          //           width: 150,
          //           height: 35,
          //           decoration: BoxDecoration(
          //             color: blueColor,
          //             borderRadius: const BorderRadius.only(
          //               topLeft: Radius.circular(35),
          //               bottomRight: Radius.circular(4),
          //             ),
          //             // borderRadius: BorderRadius.circular(12),
          //           ),
          //           child: ClipRRect(
          //             borderRadius:
          //                 const BorderRadius.only(topLeft: Radius.circular(35)),
          //             child: SizedBox(
          //               height: 35,
          //               width: 150,
          //               child: TextButton(
          //                 onPressed: () {
          //                   launchUrl(url);
          //                 },
          //                 child: const Text(
          //                   'Register Now',
          //                   style: TextStyle(
          //                     color: whiteColor,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),
        ],
      ),
    );
  }

  Future<void> launchUrls(var url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class CustomeIconContainer extends StatelessWidget {
  const CustomeIconContainer({
    super.key,
    required this.icon,
    required this.press,
  });
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: blueColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 25,
          color: whiteColor,
        ),
      ),
    );
  }
}
