import 'package:get/get.dart';

class VmVideo extends GetxController {

  bool isLoading = true;
  final VmVideo controller = Get.put(VmVideo());
  String siteName = 'https://www.youtube.com/results?search_query=%ED%99%88%ED%8A%B8%EC%9A%B4%EB%8F%99';

  show(){
    update();
  }
}
