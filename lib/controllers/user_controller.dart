import 'dart:async';
import 'package:get/get.dart';
import 'package:products/firebase_services/auth_service.dart';
import 'package:products/models/user_model.dart';

class UserController extends GetxController {
  var user = UserModel().obs;
  var res = "".obs;

  Future login() async {
   await AuthenticationService().signIn(user.value).then((value){
     res.value = value;
   });
  }

  Future register() async {
    await AuthenticationService().signUp(user.value).then((value){
      res.value = value;
    });
  }

  Future logout() async {
   await AuthenticationService().signOut();
  }

}