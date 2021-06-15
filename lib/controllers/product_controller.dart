import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:products/models/product_model.dart';
import 'package:products/firebase_services/crud_service.dart';

class ProductController extends GetxController {

  var prod = ProductModel().obs;
  var res = "".obs;
  File file;

  Future addImage(File image) async {
    var url;
    await CrudService().uploadImage(image).then((value) => url = value);
    return url;
  }

  Future addProd() async {
    await CrudService().insert(prod.value).then((value) {
    res.value = value;
    });
  }

}