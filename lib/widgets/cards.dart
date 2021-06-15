import 'package:flutter/material.dart';
import 'package:products/constants/constants.dart';

class HomeCard extends StatelessWidget {
  final str;

  HomeCard({@required this.str});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Container(
                height: 140,
                width: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage((str["photo"] != null)
                      ? str["photo"]
                      : "https://firebasestorage.googleapis.com/v0/b/products-175ea.appspot.com/o/no_image.jpg?alt=media&token=e5a2a838-e3f4-4164-90b7-676b9ed9694b"),
                ))),
            height10,
            Text(
              str["name"],
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            height10,
            Text(
              "₹${str["price"]}",
              style: TextStyle(
                  fontSize: 15,
                  color: redColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline),
            ),
            height10,
            Text(
              str["description"],
              style: TextStyle(letterSpacing: 1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
