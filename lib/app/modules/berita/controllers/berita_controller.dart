import 'package:get/get.dart';

class BeritaController extends GetxController {
  // Observable for current navigation index
  var currentNavIndex = 1.obs; // Set to 1 since this is the Berita page
  
  // Observable for search text
  var searchText = ''.obs;
  
  // Observable for selected category
  var selectedCategory = 'Semua'.obs;
  
  // Categories for news filtering
  final List<String> categories = [
    'Semua',
    'Akademik',
    'Ekstrakurikuler',
    'Prestasi',
    'Kegiatan',
    'Pengumuman'
  ];
  
  // Sample news data for SMPN 5
  final List<Map<String, dynamic>> allNews = [
    {
      'id': 1,
      'title': 'Siswa SMPN 5 Juara 1 Olimpiade Matematika Tingkat Kota',
      'category': 'Prestasi',
      'date': '22 Mei 2025',
      'author': 'Tim Redaksi',
      'image': 'assets/news/math_olympiad.jpg',
      'excerpt': 'Tim olimpiade matematika SMPN 5 berhasil meraih juara 1 dalam kompetisi tingkat kota yang diselenggarakan...',
      'content': 'Tim olimpiade matematika SMPN 5 berhasil meraih juara 1 dalam kompetisi tingkat kota yang diselenggarakan oleh Olimpiade SMA Negeri 3 Malang',
      'views': 245,
    },
    {
      'id': 2,
      'title': 'Penerimaan Siswa Baru Tahun Ajaran 2025/2026',
      'category': 'Pengumuman',
      'date': '20 Mei 2025',
      'author': 'Panitia PSB',
      'image': 'assets/news/psb_2025.jpg',
      'excerpt': 'Pendaftaran siswa baru untuk tahun ajaran 2025/2026 telah dibuka. Calon siswa dapat mendaftar mulai tanggal...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 892,
    },
    {
      'id': 3,
      'title': 'Festival Seni dan Budaya SMPN 5 Sukses Digelar',
      'category': 'Kegiatan',
      'date': '18 Mei 2025',
      'author': 'OSIS SMPN 5',
      'image': 'assets/news/festival_seni.jpg',
      'excerpt': 'Festival seni dan budaya tahunan SMPN 5 telah sukses digelar dengan menampilkan berbagai pertunjukan...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 156,
    },
    {
      'id': 4,
      'title': 'Tim Robotika SMPN 5 Lolos ke Tingkat Nasional',
      'category': 'Prestasi',
      'date': '15 Mei 2025',
      'author': 'Pembina Robotika',
      'image': 'assets/news/robotika.jpg',
      'excerpt': 'Setelah meraih juara 2 di tingkat provinsi, tim robotika SMPN 5 berhasil lolos untuk mengikuti kompetisi nasional...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 324,
    },
    {
      'id': 5,
      'title': 'Implementasi Kurikulum Merdeka di SMPN 5',
      'category': 'Akademik',
      'date': '12 Mei 2025',
      'author': 'Wakil Kepala Sekolah',
      'image': 'assets/news/kurikulum_merdeka.jpg',
      'excerpt': 'SMPN 5 telah resmi menerapkan Kurikulum Merdeka untuk meningkatkan kualitas pembelajaran...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 567,
    },
    {
      'id': 6,
      'title': 'Kegiatan Bakti Sosial Siswa SMPN 5',
      'category': 'Kegiatan',
      'date': '10 Mei 2025',
      'author': 'PMR SMPN 5',
      'image': 'assets/news/baksos.jpg',
      'excerpt': 'Siswa-siswi SMPN 5 mengadakan kegiatan bakti sosial di panti asuhan dan memberikan bantuan kepada...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 189,
    },
    {
      'id': 7,
      'title': 'Pelatihan Digital Literacy untuk Guru SMPN 5',
      'category': 'Akademik',
      'date': '8 Mei 2025',
      'author': 'Tim IT',
      'image': 'assets/news/digital_literacy.jpg',
      'excerpt': 'Para guru SMPN 5 mengikuti pelatihan digital literacy untuk meningkatkan kemampuan mengajar di era digital...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 234,
    },
    {
      'id': 8,
      'title': 'Tim Basket SMPN 5 Juara 2 Turnamen Antar Sekolah',
      'category': 'Ekstrakurikuler',
      'date': '5 Mei 2025',
      'author': 'Pelatih Basket',
      'image': 'assets/news/basket.jpg',
      'excerpt': 'Tim basket putra SMPN 5 berhasil meraih juara 2 dalam turnamen basket antar sekolah se-kecamatan...',
      'content': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'views': 432,
    },
  ];
  
  // Filtered news based on search and category
  List<Map<String, dynamic>> get filteredNews {
    List<Map<String, dynamic>> filtered = allNews;
    
    // Filter by category
    if (selectedCategory.value != 'Semua') {
      filtered = filtered.where((news) => news['category'] == selectedCategory.value).toList();
    }
    
    // Filter by search text
    if (searchText.value.isNotEmpty) {
      filtered = filtered.where((news) => 
        news['title'].toLowerCase().contains(searchText.value.toLowerCase()) ||
        news['excerpt'].toLowerCase().contains(searchText.value.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }
  
  // Navigation methods
  void changeNavIndex(int index) {
    currentNavIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed('/home');
        break;
      case 1:
        // Already on Berita page, do nothing
        break;
      case 2:
        Get.offNamed('/notifikasi');
        break;
    }
  }
  
  // Search method
  void onSearchChanged(String value) {
    searchText.value = value;
  }
  
  // Category selection method
  void selectCategory(String category) {
    selectedCategory.value = category;
  }
  
  // View news detail method
  void viewNewsDetail(int newsId) {
    Get.toNamed('/news-detail', arguments: newsId);
  }
  
  // Refresh method
  Future<void> refreshNews() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    // In real app, you would fetch news from API here
  }
}