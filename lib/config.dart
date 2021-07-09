import 'package:get/get.dart';
import 'package:crypto_currencies/controllers/theme.controller.dart';

initConfigurations() {

  // GetX Bindings
  Get.lazyPut<ThemeController>(() => ThemeController());
}