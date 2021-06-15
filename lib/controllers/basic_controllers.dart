import 'package:get/get.dart';


class BasicController extends GetxController {

final obscureText = true.obs;
void passToggle() => obscureText.value = !obscureText.value;

var lmt = 10.obs;
void limitIncrement() => lmt.value += 10;
}