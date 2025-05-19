import 'package:get/get.dart';
import '../controllers/starting_controller.dart';

class StartingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartingController>(
      () => StartingController(),
    );
  }
}