import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:products/constants/constants.dart';
import 'package:products/controllers/basic_controllers.dart';
import 'package:products/controllers/user_controller.dart';
import 'package:products/custom_class/authentication_wrapper.dart';
import 'package:products/firebase_services/auth_service.dart';
import 'package:products/widgets/alerts.dart';


final BasicController basicController = Get.put(BasicController(), tag: "basic-control");

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var _eml, _pass;
  final _userController = Get.put(UserController(), tag: "user_controller");


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: 25, top: 100, right: 25, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Authenticate yourself",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                height60,
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: lightBlueColor, width: 2
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: redColor, width: 2,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (val) {
                                if (val.isNotEmpty &&
                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)) {
                                  return null;
                                }
                                return "Enter valid email";
                              },
                              onChanged: (val) {
                               _eml = val.trim();
                              },
                            ),

                            height30,

                            Obx(() => TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: IconButton(
                                    color: blackColor,
                                    onPressed: () => basicController.passToggle(),
                                    icon: Icon(basicController.obscureText.value
                                        ? Icons.lock_open
                                        : Icons.lock)),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: lightBlueColor, width: 2
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: redColor, width: 2,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (val) => val.length < 6 || val.length > 20
                                  ? 'Password should be between 6 to 20 chars.'
                                  : null,
                              onChanged: (val) {
                                _pass = val.trim();
                              },
                              obscureText: basicController.obscureText.value,
                            ),
                            ),

                        height30,
                        height10,

                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 10),
                                  blurRadius: (10 == 0) ? 0 : 20 //(x,y)
                              ),
                            ],
                          ),
                          child: RawMaterialButton(
                            child: Text("login", style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: whiteColor)),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                _userController.user.value.email = _eml;
                                _userController.user.value.password = _pass;
                               await _userController.login();
                                if(_userController.res.value == "wrong pass"){
                                    Alerts().snackBar(context, "Incorrect Password");
                                }
                                else if(_userController.res.value != "success"){
                                  Alerts().snackBar(context, "This user is not registered");
                                }
                              }
                            },
                          ),
                        ),

                        height10,
                        Text("OR", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        height10,

                        Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 10),
                                  blurRadius: (10 == 0) ? 0 : 20 //(x,y)
                              ),
                            ],
                          ),
                          child: RawMaterialButton(
                            child: Text("register", style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: whiteColor)),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                _userController.user.value.email = _eml;
                                _userController.user.value.password = _pass;
                                await _userController.register();
                                if(_userController.res.value == "success"){
                                   Alerts().snackBar(context, "User has been registered");
                                }
                                else if(_userController.res.value == "email in use"){
                                  Alerts().snackBar(context, "Email is already in use...Try to login instead");
                                }
                                else{
                                  Alerts().snackBar(context, "Something went wrong");
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
