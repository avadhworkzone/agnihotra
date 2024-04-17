import 'package:get/get.dart';

class SettingScreenController extends GetxController{
  RxBool on = false.obs;
  void toggle() => on.value = on.value ? false : true;

  RxBool on1 = false.obs;
  void toggle1() => on1.value = on1.value ? false : true;

  RxBool on2 = false.obs;
  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on3 = false.obs;
  void toggle3() => on3.value = on3.value ? false : true;

  RxBool on4 = false.obs;
  void toggle4() => on4.value = on4.value ? false : true;

}