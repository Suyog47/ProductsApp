import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products/constants/constants.dart';
import 'package:products/controllers/product_controller.dart';
import 'package:products/custom_class/navigations.dart';

class InsertImage extends StatefulWidget {
  @override
  _InsertImageState createState() => _InsertImageState();
}

class _InsertImageState extends State<InsertImage> {

  File _image1;
  final _productController = Get.put(ProductController(), tag: "product-controller");

  _imgFromGallery(ImageSource source) async {
    final picker = ImagePicker();
    dynamic image = await picker.getImage(source: source);

    setState(() {
      if (image != null) {
        _image1 = File(image.path);
        base64Encode(_image1.readAsBytesSync());
      } else {
        _productController.prod.value.image = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Add an Image",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            toolbarHeight: 70,
            backgroundColor: darkBlueColor,
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: redColor, width: 3),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (_image1 == null ) ?
                          Image.asset(
                            'assets/default_product.png',
                            fit: BoxFit.contain,
                          ).image :
                          Image.file(
                            _image1,
                            fit: BoxFit.fill,
                          ).image,)
                    ),
                    height: 370,
                    width: 270,
                  ),

                  height10,
                  height10,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                       height: 60,
                       width: 140,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35), color: darkBlueColor),
                            child: RawMaterialButton(
                                    onPressed: (){
                                      _imgFromGallery(ImageSource.camera);
                                    },
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                          Icon(Icons.camera_alt, color: whiteColor, size: 28,),
                                          width5,
                                          Text("Camera", style: TextStyle(color: whiteColor, fontSize: 20),),
                                           ],
                                          ),
                                          ),
                                          ),

                                Container(
                                height: 60,
                                width: 140,
                                 decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35), color: darkBlueColor),
                                    child: RawMaterialButton(
                                     onPressed: (){
                                       _imgFromGallery(ImageSource.gallery);
                                     },
                                      child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         Icon(Icons.photo, color: whiteColor, size: 28,),
                                         width5,
                                         Text("Galary", style: TextStyle(color: whiteColor, fontSize: 20),)
                                         ],
                                         ),
                                         ),
                                         )

                    ],
                  ),

                  height10,
                  height5,

                  Container(
                    height: 60,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35), color: redColor),
                    child: RawMaterialButton(
                      onPressed: () async {
                        _productController.file = _image1;
                        Navigate().toAddProduct(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward, color: whiteColor, size: 28,),
                          width5,
                          Text("Next", style: TextStyle(color: whiteColor, fontSize: 20),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
