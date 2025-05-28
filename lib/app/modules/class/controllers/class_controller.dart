import 'package:get/get.dart';

class ClassController extends GetxController {
  // Informasi kelas
  final RxString className = 'Kelas 6-G-6'.obs;
  final RxString waliKelas = 'Sevina Zuhri W. S.Pd'.obs;

  // Tab saat ini: 0 = Mata Pelajaran, 1 = Tugas
  final RxInt currentTabIndex = 0.obs;

  // Daftar mata pelajaran
  final RxList<Map<String, dynamic>> subjects = <Map<String, dynamic>>[
    {
      'name': 'Matematika',
      'teacher': 'Dra. Siti Rahayu, M.Mat',
      'icon': 'assets/logo/icons/matematika.png',
      'color': 0xFFFFCDD2,
      'completion': 85,
      'next_session': 'Senin, 08:00 - 09:30',
      'material': 'Persamaan Kuadrat',
    },
    {
      'name': 'Bahasa Indonesia',
      'teacher': 'Drs. Budi Santoso, M.Pd',
      'icon': 'assets/logo/icons/bindo.png',
      'color': 0xFFBBDEFB,
      'completion': 90,
      'next_session': 'Selasa, 10:00 - 11:30',
      'material': 'Teks Narasi',
    },
    {
      'name': 'Bahasa Inggris',
      'teacher': 'Dra. Sri Mulyani, M.Hum',
      'icon': 'assets/logo/icons/bing.png',
      'color': 0xFFE1BEE7,
      'completion': 75,
      'next_session': 'Rabu, 08:00 - 09:30',
      'material': 'Present Perfect Tense',
    },
    {
      'name': 'IPA',
      'teacher': 'Dr. Agus Widodo, M.Si',
      'icon': 'assets/logo/icons/ipa.png',
      'color': 0xFFC8E6C9,
      'completion': 80,
      'next_session': 'Kamis, 12:30 - 14:00',
      'material': 'Sistem Pencernaan',
    },
    {
      'name': 'IPS',
      'teacher': 'Dra. Ratna Dewi, M.Pd',
      'icon': 'assets/logo/icons/ips.png',
      'color': 0xFFFFF9C4,
      'completion': 70,
      'next_session': 'Jumat, 10:00 - 11:30',
      'material': 'Sejarah Kerajaan Nusantara',
    },
    {
      'name': 'Seni Budaya',
      'teacher': 'Eko Prabowo, S.Sn',
      'icon': 'assets/logo/icons/seni.png',
      'color': 0xFFFFE0B2,
      'completion': 95,
      'next_session': 'Selasa, 12:30 - 14:00',
      'material': 'Seni Lukis Modern',
    },
    {
      'name': 'PJOK',
      'teacher': 'Hendra Wijaya, S.Pd',
      'icon': 'assets/logo/icons/pjok.png',
      'color': 0xFFB3E5FC,
      'completion': 88,
      'next_session': 'Rabu, 14:00 - 15:30',
      'material': 'Permainan Bola Basket',
    },
    {
      'name': 'PPKn',
      'teacher': 'Drs. Sutrisno, M.Pd',
      'icon': 'assets/logo/icons/ppkn.png',
      'color': 0xFFD1C4E9,
      'completion': 82,
      'next_session': 'Kamis, 10:00 - 11:30',
      'material': 'Pancasila dan UUD 1945',
    },
    {
      'name': 'Informatika',
      'teacher': 'Ir. Dian Permata, M.Kom',
      'icon': 'assets/logo/icons/informatika.png',
      'color': 0xFFB2EBF2,
      'completion': 92,
      'next_session': 'Jumat, 08:00 - 09:30',
      'material': 'Dasar Pemrograman',
    },
  ].obs;

  // Daftar tugas
  final RxList<Map<String, dynamic>> assignments = <Map<String, dynamic>>[
    {
      'title': 'Tugas Matematika - Persamaan Kuadrat',
      'subject': 'Matematika',
      'teacher': 'Dra. Siti Rahayu, M.Mat',
      'deadline': 'Senin, 25 Mei 2025, 23:59',
      'submitted': false,
      'description': 'Kerjakan soal persamaan kuadrat halaman 45-46 nomor 1-10.',
      'color': 0xFFFFCDD2,
    },
    {
      'title': 'Analisis Teks Narasi - Cerpen',
      'subject': 'B.  Indo',
      'teacher': 'Drs. Budi Santoso, M.Pd',
      'deadline': 'Rabu, 27 Mei 2025, 23:59',
      'submitted': true,
      'description': 'Buatlah analisis struktur dari cerpen yang telah dibagikan.',
      'color': 0xFFBBDEFB,
    },
    {
      'title': 'Present Perfect Tense - Exercise',
      'subject': 'B. Ing',
      'teacher': 'Dra. Sri Mulyani, M.Hum',
      'deadline': 'Kamis, 28 Mei 2025, 23:59',
      'submitted': false,
      'description':
          'Complete the exercises on Present Perfect Tense from the workbook page 32-33.',
      'color': 0xFFE1BEE7,
    },
    {
      'title': 'Laporan Pengamatan Sistem Pencernaan',
      'subject': 'IPA',
      'teacher': 'Dr. Agus Widodo, M.Si',
      'deadline': 'Jumat, 29 Mei 2025, 23:59',
      'submitted': false,
      'description': 'Buatlah laporan hasil pengamatan praktikum sistem pencernaan.',
      'color': 0xFFC8E6C9,
    },
    {
      'title': 'Presentasi Kerajaan Nusantara',
      'subject': 'IPS',
      'teacher': 'Dra. Ratna Dewi, M.Pd',
      'deadline': 'Senin, 1 Juni 2025, 23:59',
      'submitted': false,
      'description': 'Siapkan presentasi kelompok tentang salah satu kerajaan di Nusantara.',
      'color': 0xFFFFF9C4,
    },
    {
      'title': 'Praktik Pemrograman Dasar',
      'subject': 'Informatika',
      'teacher': 'Ir. Dian Permata, M.Kom',
      'deadline': 'Selasa, 2 Juni 2025, 23:59',
      'submitted': true,
      'description': 'Kerjakan latihan pemrograman dasar dengan menggunakan pseudocode.',
      'color': 0xFFB2EBF2,
    },
  ].obs;

  // Fungsi mengganti tab
  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  // Navigasi ke detail pelajaran
  void viewSubjectDetail(int index) {
    final subject = subjects[index];
    Get.toNamed('/subject-detail', arguments: subject);
  }

  // Navigasi ke detail tugas
  void viewAssignmentDetail(int index) {
    final assignment = assignments[index];
    Get.toNamed('/assignment-detail', arguments: assignment);
  }

  // Fungsi untuk mengumpulkan tugas
  void submitAssignment(int index) {
    final assignment = Map<String, dynamic>.from(assignments[index]);
    assignment['submitted'] = true;
    assignments[index] = assignment;

    Get.snackbar(
      'Berhasil',
      'Tugas berhasil dikumpulkan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Navigasi kembali ke halaman sebelumnya
  void backToHome() {
    Get.back();
  }
}
