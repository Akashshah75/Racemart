import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:racemart_app/Utils/app_color.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import '../../../../Utils/app_asset.dart';

class ImageHedingContainer extends StatelessWidget {
  const ImageHedingContainer({
    super.key,
    required this.image,
    required this.title,
    required this.shareUrl,
  });
  final String image;
  final String title;
  final String shareUrl;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: title,
      transitionOnUserGestures: true,
      child: Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.topLeft,
        width: double.infinity,
        height: 180,
        decoration: image != demo
            ? BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomeIconContainer(
                  icon: Icons.arrow_back,
                  press: () {
                    Navigator.of(context).pop();
                  }),
              Row(
                children: [
                  // CustomeIconContainer(icon: Icons.favorite, press: () {}),
                  // ////
                  // const SizedBox(width: 8),
                  CustomeIconContainer(
                      icon: Icons.share,
                      press: () async {
                        var urlImage =
                            image; //widget.data['poster']; //urlImage1;
                        final Uri url = Uri.parse(urlImage);
                        final res = await http.get(url);
                        final bytes = res.bodyBytes;
                        //
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        //
                        // ignore: deprecated_member_use
                        await Share.shareFiles([path], text: shareUrl);
                      }),

                  //
                ],
                //
              ),
              //
            ],
          ),
        ),
      ),
    );
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
