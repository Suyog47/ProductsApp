import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:products/custom_class/image_compression.dart';
import 'package:products/models/product_model.dart';

class CrudService {
  CollectionReference product = FirebaseFirestore.instance
      .collection("products_of_${FirebaseAuth.instance.currentUser.email}");
  var url;

  Stream<QuerySnapshot> prodStream() => FirebaseFirestore.instance
      .collection("products_of_${FirebaseAuth.instance.currentUser.email}")
      .snapshots();

  Future insert(ProductModel prod) async {
    var res = await product
        .add({
          "photo": prod.image,
          "name": prod.name,
          "price": prod.price,
          "description": prod.desc,
        })
        .then((value) => "success")
        .catchError((e) => "failed");
    return res;
  }

  Future<String> uploadImage(File file) async {
    File compressedFile = await ImageCompressor().compress(file);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("uploads/" +
        FirebaseAuth.instance.currentUser.email +
        "-" +
        basename(compressedFile.path));
    UploadTask uploadTask = ref.putFile(compressedFile);
    await uploadTask.then((res) async {
      await res.ref.getDownloadURL().then((value) {
        url = value;
      });
    });
    return url.toString();
  }
}
