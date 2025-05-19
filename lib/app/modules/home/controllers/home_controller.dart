import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable variables
  final RxString greeting = 'Good Morning!'.obs;
  final RxString userName = 'Zacky'.obs;
  final RxString userPhone = ''.obs;

  final RxInt currentNavIndex = 0.obs;

  // Weekly performance stats
  final RxList<double> weeklyStats = <double>[0.5, 0.7, 0.9, 0.6, 0.3].obs;

  // Menu items
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Absensi',
      'icon': 'assets/logo/icons/absensi.png',
      'color': 0xFFFFF8E1,
    },
    {
      'title': 'Ekstrakulikuler',
      'icon': 'assets/logo/icons/ekstrakulikuler.png',
      'color': 0xFFE8F5E9,
    },
    {
      'title': 'Kalender SpenMa',
      'icon': 'assets/logo/icons/kalender.png',
      'color': 0xFFFFEBEE,
    },
    {
      'title': 'Kelas',
      'icon': 'assets/logo/icons/kelas.png',
      'color': 0xFFE3F2FD,
    },
    {
      'title': 'Event Sekolah',
      'icon': 'assets/logo/icons/event.png',
      'color': 0xFFF3E5F5,
    },
  ];

  // Top students list
  final RxList<Map<String, dynamic>> topStudents = <Map<String, dynamic>>[
    {
      'name': 'BARRU HAFIZH',
      'class': '6B1',
      'rating': 4.9,
      'image': 'assets/logo/images/barru.jpg',
    },
    {
      'name': 'BONO TRI CAHYONO',
      'class': 'Kelas 7 IPA-2',
      'rating': 4.8,
      'image': 'assets/logo/images/dyandra.jpg',
    },
    {
      'name': 'LENA KATARINA',
      'class': 'Kelas 7 IPA-3',
      'rating': 4.9,
      'image': 'assets/logo/images/iky.jpg',
    },
    {
      'name': 'ALI SURYO SANJAYA',
      'class': 'Kelas 7 IPA-4',
      'rating': 4.7,
      'image': 'assets/logo/images/laura.jpg',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    _setGreetingBasedOnTime();
    _loadUserData();
  }

  // Load user data
  void _loadUserData() {
    userName.value = 'Zacky';
    userPhone.value = '+62 812-3456-7890';
  }

  // Greeting logic
  void _setGreetingBasedOnTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Selamat Pagi!';
    } else if (hour < 17) {
      greeting.value = 'Selamat Siang!';
    } else {
      greeting.value = 'Selamat Sore!';
    }
  }

  // Bottom nav index
  void changeNavIndex(int index) {
    currentNavIndex.value = index;
    switch (index) {
      case 0:
        break;
      case 1:
        Get.toNamed('/reports');
        break;
      case 2:
        Get.toNamed('/edit-profile');
        break;
      case 3:
        Get.toNamed('/analytics');
        break;
    }
  }

  // Menu item tap
  void onMenuItemTap(int index) {
    switch (index) {
      case 0:
        Get.toNamed('/attendance');
        break;
      case 1:
        Get.toNamed('/extracurricular');
        break;
      case 2:
        Get.toNamed('/calendar');
        break;
      case 3:
        Get.toNamed('/classes');
        break;
      case 4:
        Get.toNamed('/events');
        break;
    }
  }

  void viewStudentDetails(int index) {
    final student = topStudents[index];
    Get.toNamed('/student-detail', arguments: student);
  }

  void viewPerformanceDetails() {
    Get.toNamed('/starting');
  }

  void navigateToMyAccount() {
    Get.toNamed('/my-account');
  }

  void navigateToSettings() {
    Get.toNamed('/settings');
  }

  void logout() {
    // Perform logout
    Get.offAllNamed('/login');
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    weeklyStats.value = [0.6, 0.8, 0.7, 0.5, 0.4];
    update();
  }
}
