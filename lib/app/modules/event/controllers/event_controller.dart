import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  // Observable variables
  var selectedCategory = 'Semua'.obs;
  var searchQuery = ''.obs;
  var currentEventIndex = 0.obs;
  
  // Categories for filtering events
  final List<String> categories = [
    'Semua',
    'Akademik',
    'Seni & Budaya',
    'Olahraga',
    'Sosial',
    'Kompetisi'
  ];

  // Sample events data
  final RxList<Map<String, dynamic>> events = <Map<String, dynamic>>[
    {
      'id': 1,
      'title': 'HUT SMPN 5 ke-45',
      'category': 'Sosial',
      'date': '15 Agustus 2024',
      'time': '08:00 - 15:00',
      'location': 'Aula SMPN 5',
      'description': 'Perayaan Hari Ulang Tahun SMPN 5 yang ke-45 dengan berbagai rangkaian acara menarik termasuk upacara, pentas seni, dan pameran karya siswa.',
      'image': 'assets/events/hut_school.jpg',
      'participants': 450,
      'organizer': 'OSIS SMPN 5',
      'status': 'upcoming',
      'tags': ['HUT', 'Perayaan', 'Sekolah'],
      'highlights': [
        'Upacara bendera khidmat',
        'Pentas seni siswa-siswi',
        'Pameran karya siswa',
        'Lomba antar kelas'
      ]
    },
    {
      'id': 2,
      'title': 'Konser Musik Sekolah',
      'category': 'Seni & Budaya',
      'date': '22 September 2024',
      'time': '19:00 - 21:30',
      'location': 'Auditorium Sekolah',
      'description': 'Konser musik tahunan yang menampilkan band sekolah, paduan suara, dan solo performance dari siswa-siswi berbakat.',
      'image': 'assets/events/concert.jpg',
      'participants': 300,
      'organizer': 'Ekstrakurikuler Musik',
      'status': 'upcoming',
      'tags': ['Musik', 'Konser', 'Ekstrakurikuler'],
      'highlights': [
        'Performance band sekolah',
        'Solo music performance',
        'Paduan suara',
        'Special guest performance'
      ]
    },
    {
      'id': 3,
      'title': 'Projek P5 - Kearifan Lokal',
      'category': 'Akademik',
      'date': '5 Oktober 2024',
      'time': '07:30 - 12:00',
      'location': 'Seluruh Area Sekolah',
      'description': 'Presentasi dan pameran hasil Projek Penguatan Profil Pelajar Pancasila (P5) dengan tema Kearifan Lokal Nusantara.',
      'image': 'assets/events/p5_project.jpg',
      'participants': 500,
      'organizer': 'Tim P5 SMPN 5',
      'status': 'ongoing',
      'tags': ['P5', 'Pendidikan', 'Kearifan Lokal'],
      'highlights': [
        'Pameran produk lokal',
        'Presentasi kelompok',
        'Workshop budaya',
        'Degustasi makanan tradisional'
      ]
    },
    {
      'id': 4,
      'title': 'Bazar Sekolah 2024',
      'category': 'Sosial',
      'date': '28 Oktober 2024',
      'time': '09:00 - 16:00',
      'location': 'Lapangan Sekolah',
      'description': 'Bazar tahunan sekolah dengan berbagai stand makanan, kerajinan, dan produk hasil karya siswa untuk menggalang dana kegiatan sekolah.',
      'image': 'assets/events/school_bazaar.jpg',
      'participants': 600,
      'organizer': 'Komite Sekolah',
      'status': 'upcoming',
      'tags': ['Bazar', 'Fundraising', 'Komunitas'],
      'highlights': [
        'Stand makanan tradisional',
        'Kerajinan tangan siswa',
        'Games dan doorprize',
        'Penampilan musik live'
      ]
    },
    {
      'id': 5,
      'title': 'Pentas Seni Tahunan',
      'category': 'Seni & Budaya',
      'date': '12 November 2024',
      'time': '18:30 - 21:00',
      'location': 'Aula Utama',
      'description': 'Ajang pentas seni tahunan yang menampilkan berbagai talenta siswa dalam bidang tari, drama, musik, dan seni rupa.',
      'image': 'assets/events/art_performance.jpg',
      'participants': 350,
      'organizer': 'Ekstrakurikuler Seni',
      'status': 'upcoming',
      'tags': ['Seni', 'Pentas', 'Talenta'],
      'highlights': [
        'Tari tradisional dan modern',
        'Pentas drama',
        'Pameran seni rupa',
        'Fashion show'
      ]
    },
    {
      'id': 6,
      'title': 'Olimpiade Sains Sekolah',
      'category': 'Kompetisi',
      'date': '3 Desember 2024',
      'time': '08:00 - 15:00',
      'location': 'Ruang Kelas 7-9',
      'description': 'Kompetisi sains tingkat sekolah untuk memilih wakil dalam olimpiade sains tingkat kabupaten.',
      'image': 'assets/events/science_olympiad.jpg',
      'participants': 120,
      'organizer': 'Tim Olimpiade SMPN 5',
      'status': 'upcoming',
      'tags': ['Olimpiade', 'Sains', 'Kompetisi'],
      'highlights': [
        'Kompetisi Matematika',
        'Kompetisi IPA',
        'Kompetisi IPS',
        'Pembagian hadiah'
      ]
    },
    {
      'id': 7,
      'title': 'Tournament Futsal Antar Kelas',
      'category': 'Olahraga',
      'date': '18 Januari 2025',
      'time': '14:00 - 17:00',
      'location': 'Lapangan Futsal',
      'description': 'Turnamen futsal antar kelas untuk mempererat tali persaudaraan dan mengembangkan bakat olahraga siswa.',
      'image': 'assets/events/futsal_tournament.jpg',
      'participants': 200,
      'organizer': 'Ekstrakurikuler Futsal',
      'status': 'upcoming',
      'tags': ['Futsal', 'Tournament', 'Olahraga'],
      'highlights': [
        'Sistem knockout',
        'Hadiah untuk juara',
        'Sertifikat partisipasi',
        'Refreshment gratis'
      ]
    }
  ].obs;

  // Filtered events based on category and search
  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = events;
    
    // Filter by category
    if (selectedCategory.value != 'Semua') {
      filtered = filtered.where((event) => 
        event['category'] == selectedCategory.value).toList();
    }
    
    // Filter by search query
    if (searchQuery.value.isNotEmpty) {
      filtered = filtered.where((event) =>
        event['title'].toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        event['description'].toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
    }
    
    return filtered;
  }

  // Method to change category filter
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // Method to update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Method to navigate to event detail
  void navigateToEventDetail(int eventId) {
    // Find the event by ID
    final event = events.firstWhere((e) => e['id'] == eventId);
    
    // Navigate to event detail page (you can implement this)
    Get.toNamed('/event-detail', arguments: event);
    print('Navigating to event detail: ${event['title']}');
  }

  // Method to register for event
  void registerForEvent(int eventId) {
    final event = events.firstWhere((e) => e['id'] == eventId);
    
    // Show confirmation dialog
    Get.dialog(
      AlertDialog(
        title: const Text('Daftar Event'),
        content: Text('Apakah Anda yakin ingin mendaftar untuk event "${event['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Berhasil!',
                'Anda telah terdaftar untuk event ${event['title']}',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF4CAF50),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBE5B50),
            ),
            child: const Text('Daftar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Method to share event
  void shareEvent(int eventId) {
    final event = events.firstWhere((e) => e['id'] == eventId);
    
    Get.snackbar(
      'Berbagi Event',
      'Event "${event['title']}" telah dibagikan!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFBAAD93),
      colorText: Colors.white,
    );
  }

  // Method to add event to calendar
  void addToCalendar(int eventId) {
    final event = events.firstWhere((e) => e['id'] == eventId);
    
    Get.snackbar(
      'Ditambahkan ke Kalender',
      'Event "${event['title']}" telah ditambahkan ke kalender Anda!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFBAAD93),
      colorText: Colors.white,
    );
  }

  // Get event status color
  Color getStatusColor(String status) {
    switch (status) {
      case 'ongoing':
        return const Color(0xFF4CAF50);
      case 'upcoming':
        return const Color(0xFF2196F3);
      case 'completed':
        return const Color(0xFF9E9E9E);
      default:
        return const Color(0xFF2196F3);
    }
  }

  // Get event status text
  String getStatusText(String status) {
    switch (status) {
      case 'ongoing':
        return 'Sedang Berlangsung';
      case 'upcoming':
        return 'Akan Datang';
      case 'completed':
        return 'Selesai';
      default:
        return 'Akan Datang';
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}