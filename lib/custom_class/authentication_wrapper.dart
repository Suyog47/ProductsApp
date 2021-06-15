import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:products/screens/authentication/authenticate.dart';
import 'package:products/screens/home/home.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user != null){
      return Home();
    }
    else{
      return Login();
    }
  }
}
