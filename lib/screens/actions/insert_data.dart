import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:products/constants/constants.dart';
import 'package:products/controllers/product_controller.dart';
import 'package:products/widgets/circular_avatar.dart';


class InsertData extends StatefulWidget {
  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {

  var name, price, desc;
  final _formKey = GlobalKey<FormState>();
  final _productController = Get.put(ProductController(), tag: "product-controller");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Add a Product",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              toolbarHeight: 70,
              backgroundColor: darkBlueColor,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      height30,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: darkBlueColor, width: 2
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
                          if (val.isNotEmpty) {
                            return null;
                          }
                          return "Enter product name";
                        },
                        onChanged: (val) {
                          name = val.trim();
                        },
                      ),

                      height10,
                      height10,

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Price",
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: darkBlueColor, width: 2
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(7)
                        ],
                        validator: (val) => val.isEmpty ? "Enter Some Amount" : null,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          price = val.trim();
                        },
                      ),

                      height10,
                      height10,

                      TextFormField(
                        style: TextStyle(fontSize: 18,),
                        decoration: InputDecoration(
                          labelText: "Decription",
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: darkBlueColor, width: 2
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
                        cursorColor: redColor,
                        onChanged: (val) => desc = val,
                        minLines: 8,
                        maxLines: 10,
                        textAlignVertical: TextAlignVertical.top,
                      ),

                      height10,
                      height10,

                      Container(
                        width: 250,
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
                          child: Text("Add", style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: whiteColor)),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              _productController.prod.value.name = name;
                              _productController.prod.value.price = int.parse(price);
                              _productController.prod.value.desc = desc;
                              if(_productController.file != null){
                                var res = await _productController.addImage(_productController.file);
                                _productController.prod.value.image = res;
                              }
                              await _productController.addProd();
                              if(_productController.res.value == "success"){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                     content: Text("Product Added successfully", style: TextStyle(fontSize: 14),)
                                ));
                                Navigator.of(context)
                                    .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                              }
                              else{
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                     content: Text("Something went wrong", style: TextStyle(fontSize: 16),)
                                ));
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
