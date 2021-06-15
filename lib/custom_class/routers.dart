import 'package:flutter/material.dart';
import 'package:products/custom_class/page_transitions.dart';
import 'package:products/screens/actions/insert_data.dart';
import 'package:products/screens/actions/insert_image.dart';
import 'package:products/screens/authentication/authenticate.dart';
import 'package:products/screens/home/home.dart';


class Routers {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return CustomPageTransitions()
            .bottomToTopTransition(Login(), settings);
        break;

      case '/home':
        return CustomPageTransitions()
            .bottomToTopTransition(Home(), settings);
        break;

      case '/addimage':
        return CustomPageTransitions().sizeTransition(InsertImage(), settings);
        break;

      case '/addproduct':
        return CustomPageTransitions().rightToLeftFadeTransition(InsertData(), settings);
        break;


      default:
        return null;
    }
  }
}
