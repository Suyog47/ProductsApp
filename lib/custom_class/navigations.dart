import 'package:flutter/material.dart';

class Navigate {

  void toLogin(context, [Map data]) {
    Navigator.pushNamed(context, "/login", arguments: data);
  }

  void toHome(context, [Map data]) {
    Navigator.pushNamed(context, "/home", arguments: data);
  }

  void toAddImage(context, [Map data]) {
    Navigator.pushNamed(context, "/addimage", arguments: data);
  }

  void toAddProduct(context, [Map data]) {
    Navigator.pushNamed(context, "/addproduct", arguments: data);
  }
}