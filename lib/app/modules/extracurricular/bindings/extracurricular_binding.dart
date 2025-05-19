import 'package:get/get.dart';
import '../controllers/extracurricular_controller.dart';

class ExtracurricularBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExtracurricularController>(
      () => ExtracurricularController(),
    );
  }
}