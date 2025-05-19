import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register HomeController with Get's dependency injection
    Get.lazyPut<HomeController>(() => HomeController());
    
    // You can register additional controllers, repositories, 
    // or services needed for the home screen here
    
    // Example:
    // Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    // Get.lazyPut<PerformanceService>(() => PerformanceServiceImpl());
  }
}