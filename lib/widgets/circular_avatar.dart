import 'package:flutter/material.dart';
import 'package:products/constants/constants.dart';

class Avatar extends StatelessWidget {
  final networkImg;
  final galleryImg;
  final double radius;

  Avatar({this.networkImg = "", this.galleryImg = "", this.radius = 30});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CircleAvatar(
          radius: radius,
          backgroundImage: (networkImg == "" && galleryImg == "")
              ? Image.asset(
            'assets/default_product.png',
            fit: BoxFit.contain,
          ).image :
          (networkImg != "" && galleryImg == "") ?
          Image.network(
            networkImg,
            fit: BoxFit.fill,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(redColor),
            ),
          ).image :
          Image.file(
            galleryImg,
            fit: BoxFit.fill,
          ).image,
        )
    );
  }
}
