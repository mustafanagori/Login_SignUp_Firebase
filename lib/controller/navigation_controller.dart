import 'package:get/get.dart';

class HomeNavigation extends GetxController {
  @override
  void onInit() {
    changeIndex(0);
    super.onInit();
  }

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
