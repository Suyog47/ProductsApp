import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';

class ImageCompressor {
  Future compress(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
    );
    return compressedFile;
  }
}
