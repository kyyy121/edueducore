import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeController extends GetxController {
  // Observable variables
  final RxString greeting = 'Good Morning!'.obs;
  final RxString userName = 'Zacky'.obs;
  final RxString userPhone = ''.obs;

  final RxInt currentNavIndex = 0.obs;

  // Weekly performance stats
  final RxList<double> weeklyStats = <double>[0.5, 0.7, 0.9, 0.6, 0.3].obs;

  // Enhanced Slideshow variables
  final RxInt currentSlideIndex = 0.obs;
  Timer? slideshowTimer; // Menjadikan Timer nullable untuk memastikan inisialisasi yang benar
  final RxDouble slideOffset = 0.0.obs;
  late PageController pageController;
  
  final RxList<Map<String, dynamic>> slideshowItems = <Map<String, dynamic>>[
    {
      'imageUrl': 'assets/logo/images/classmeet.png',
      'title': 'Selamat Datang di SpenMa!',
    },
    {
      'imageUrl': 'assets/logo/images/hutspenma.png',
      'title': 'Event HUT SMP Negeri 5',
    },
    {
      'imageUrl': 'assets/logo/images/sertijab.png',
      'title': 'Prosesi Sertijab OSIS SpenMa',
    },
    {
      'imageUrl': 'assets/logo/images/p5.png',
      'title': 'Kegiatan P5 di SpenMa',
    },
    {
      'imageUrl': 'assets/logo/images/silahturahmi.png',
      'title': 'Silahturahmi guru guru pengajar',
    },
  ].obs;

  // Menu items
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Absensi',
      'icon': 'assets/logo/icons/absensi.png',
      'color': 0xFFF5E5C4,
    },
    {
      'title': 'Ekstrakulikuler',
      'icon': 'assets/logo/icons/ekstrakulikuler.png',
      'color': 0xFFBE5B50,
    },
    {
      'title': 'Kalender SpenMa',
      'icon': 'assets/logo/icons/kalender.png',
      'color': 0xFFF5E5C4,
    },
    {
      'title': 'Kelas',
      'icon': 'assets/logo/icons/kelas.png',
      'color': 0xFFBE5B50,
    },
    {
      'title': 'Event Sekolah',
      'icon': 'assets/logo/icons/event.png',
      'color': 0xFFF5E5C4,
    },
  ];

  // Top students list dengan deskripsi tambahan
  final RxList<Map<String, dynamic>> topStudents = <Map<String, dynamic>>[
    {
      'name': 'BARRU HAFIZH',
      'class': '6-B-1',
      'rating': 4.9,
      'image': 'assets/logo/images/barru.jpg',
      'description': 'Siswa berprestasi dengan nilai akademik tertinggi di sekolah. Aktif di organisasi OSIS sebagai ketua, serta memenangkan olimpiade sains tingkat nasional tahun 2024. Memiliki kegemaran membaca dan menulis puisi.',
      'achievements': ['Juara 1 Olimpiade Matematika', 'Ketua OSIS', 'Nilai Ujian Tertinggi']
    },
    {
      'name': 'DYANDRA KENZIE',
      'class': '6-J-5',
      'rating': 4.8,
      'image': 'assets/logo/images/dyandra.jpg',
      'description': 'Atlet muda berbakat di bidang renang yang telah mewakili sekolah di tingkat provinsi. Memiliki prestasi akademik yang bagus terutama di mata pelajaran sains dan matematika.',
      'achievements': ['Juara 2 Renang Tingkat Provinsi', 'Ketua Klub Sains', 'Peserta OSN']
    },
    {
      'name': 'IKY DIAJENG',
      'class': '6-J-5',
      'rating': 4.9,
      'image': 'assets/logo/images/iky.jpg',
      'description': 'Siswa berbakat dalam bidang seni, terutama musik dan melukis. Telah memenangkan berbagai kompetisi seni tingkat kota dan provinsi. Selain berprestasi di bidang seni, Lena juga memiliki nilai akademik yang sangat baik.',
      'achievements': ['Juara 1 Lukis Tingkat Kota', 'Ketua Klub Seni', 'Penampil Terbaik Festival Musik']
    },
    {
      'name': 'LAURA SALSABILA',
      'class': '6-G-3',
      'rating': 4.7,
      'image': 'assets/logo/images/laura.jpg',
      'description': 'Siswa dengan kemampuan luar biasa di bidang teknologi dan programming. Telah mengembangkan beberapa aplikasi untuk kegiatan sekolah. Aktif dalam kegiatan ekstrakurikuler robotik dan komputer.',
      'achievements': ['Developer Aplikasi Sekolah', 'Juara 1 Kompetisi Robotik', 'Ketua Klub Komputer']
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    
    // Initialize PageController at the beginning of the lifecycle
    pageController = PageController(initialPage: 0);
    
    _setGreetingBasedOnTime();
    _loadUserData();
    
    // Set a 100ms delay before starting slideshow to ensure widgets are properly built
    Future.delayed(const Duration(milliseconds: 100), () {
      _startSlideshowTimer();
    });
    
    // Listen to page changes from PageView
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty && pageController.page != null) {
        slideOffset.value = pageController.page!;
      }
    });
  }

  @override
  void onClose() {
    // Cancel timer safely
    if (slideshowTimer != null && slideshowTimer!.isActive) {
      slideshowTimer!.cancel();
    }
    
    // Dispose the controller
    pageController.dispose();
    super.onClose();
  }

  // Start slideshow timer with proper error handling
  void _startSlideshowTimer() {
    // Cancel any existing timer first
    if (slideshowTimer != null && slideshowTimer!.isActive) {
      slideshowTimer!.cancel();
    }
    
    // Create a new timer
    slideshowTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      try {
        if (slideshowItems.isEmpty) return;
        
        // Move to next slide, loop back to first if at the end
        final nextIndex = (currentSlideIndex.value + 1) % slideshowItems.length;
        
        // Only proceed if controller is attached to a position (widget is visible)
        if (pageController.hasClients) {
          goToSlide(nextIndex);
        }
      } catch (e) {
        print('Error in slideshow timer: $e');
      }
    });
  }

  // Go to specific slide with animation
  void goToSlide(int index) {
    if (index >= 0 && index < slideshowItems.length && pageController.hasClients) {
      currentSlideIndex.value = index;
      
      // Animate to the selected page
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Reset the slideshow timer
  void resetSlideshowTimer() {
    _startSlideshowTimer(); // This method already handles canceling existing timer
  }

  // Handle page change from PageView
  void onPageChanged(int index) {
    currentSlideIndex.value = index;
    resetSlideshowTimer();
  }

  // Handle manual swipe
  void onSlideSwipe(DragUpdateDetails details) {
    // Most of the work is handled by PageView but we can add custom behavior here
    // For example, we might want to pause the timer during active swiping
  }

  // Handle end of swipe
  void onSlideSwipeEnd(DragEndDetails details) {
    resetSlideshowTimer();
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

  // Bottom nav index - Updated for immediate navigation
  void changeNavIndex(int index) {
    // Navigate immediately based on index
    if (index != currentNavIndex.value) {
      switch (index) {
        case 0: // Home
          // If we're not already on home, navigate to it
          if (currentNavIndex.value != 0) {
            Get.offAllNamed('/'); // Navigate to home route
          }
          break;
        case 1: // Berita
          Get.offAllNamed('/berita');
          break;
        case 2: // Notifikasi
          Get.offAllNamed('/notifikasi');
          break;
      }
      // Update the index after navigation is initiated
      currentNavIndex.value = index;
    }
  }

  // Direct navigation methods if needed elsewhere
  void navigateToBerita() {
    currentNavIndex.value = 1; // Update index to match navigation
    Get.offAllNamed('/berita');
  }

  void navigateToNotifikasi() {
    currentNavIndex.value = 2; // Update index to match navigation
    Get.offAllNamed('/notifikasi');
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
        Get.toNamed('/class');
        break;
      case 4:
        Get.toNamed('/event');
        break;
    }
  }

  // Fungsi untuk navigasi ke halaman profil dari header atau tombol lain
  void navigateToProfile() {
    Get.toNamed('/profile');
  }

  // Fungsi untuk menampilkan popup detail siswa
  void viewStudentDetails(int index) {
    final student = topStudents[index];
    
    // Dialog dengan informasi lengkap siswa
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: Get.width * 0.85,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header dengan gambar student
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(student['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/icons/medal2.png', 
                              width: 24, 
                              height: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              student['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${student['class']} • Rating ${student['rating']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Content section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Deskripsi siswa
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF053158),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      student['description'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Prestasi siswa
                    const Text(
                      'Prestasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF053158),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: List.generate(
                        (student['achievements'] as List).length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFBE5B50),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  student['achievements'][i],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Button section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBE5B50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Tutup',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void viewPerformanceDetails() {
    Get.toNamed('/starting');
  }

  // Metode untuk navigasi ke halaman profil dari header atau drawer
  void navigateToMyAccount() {
    navigateToProfile();
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