import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products/firebase_services/auth_service.dart';
import 'package:provider/provider.dart';
import 'custom_class/authentication_wrapper.dart';
import 'custom_class/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        home: AuthenticationWrapper(),
        onGenerateRoute: (settings) => Routers.generateRoutes(settings),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

