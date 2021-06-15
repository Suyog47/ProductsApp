import 'package:flutter/material.dart';


class Alerts{

  void snackBar(BuildContext context, String msg){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
        content: Text(msg, style: TextStyle(fontSize: 14),)
    ));
  }
}