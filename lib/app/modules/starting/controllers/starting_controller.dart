import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartingController extends GetxController {
  final RxString studentName = 'Ahmad Dhani'.obs;
  final RxString studentId = '10001'.obs;
  final RxString studentClass = 'Kelas 10A'.obs;
  final RxList<Map<String, dynamic>> monthlyAttendance = <Map<String, dynamic>>[].obs;
  final Rx<DateTime> selectedMonth = DateTime.now().obs;
  final RxBool isLoading = false.obs;
  final RxString selectedFilter = 'semua'.obs;

  final RxList<Map<String, dynamic>> weeklyStats = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStudentAttendanceData();
  }

  void loadStudentAttendanceData() {
    isLoading.value = true;

    // Simulasi loading data dari database
    Future.delayed(const Duration(milliseconds: 800), () {
      try {
        _generateMockAttendanceData();
        _calculateWeeklyStatistics();
      } catch (e) {
        // Tangani error jika ada
        Get.snackbar(
          'Error',
          'Gagal memuat data: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    });
  }

  void _generateMockAttendanceData() {
    final List<Map<String, dynamic>> mockData = [];
    final DateTime now = selectedMonth.value;
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final DateTime nextMonth = DateTime(now.year, now.month + 1, 1);
    final int daysInMonth = nextMonth.difference(firstDayOfMonth).inDays;

    // Seed untuk randomization berdasarkan bulan
    final int seed = now.month * 31 + now.year;
    final List<String> status = ['hadir', 'sakit', 'izin', 'alpha'];
    
    for (int i = 0; i < daysInMonth; i++) {
      final DateTime date = DateTime(now.year, now.month, i + 1);

      // Hari libur (Sabtu dan Minggu)
      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
        mockData.add({
          'date': date,
          'status': 'libur',
          'notes': 'Hari libur',
        });
        continue;
      }

      // Generate status berdasarkan seed dan hari
      final int statusIndex = ((seed + i) % 10 < 7) ? 0 : 
                             ((seed + i) % 10 - 7) % 3 + 1;
      final String currentStatus = status[statusIndex];

      // Catatan yang lebih realistis
      String notes;
      switch (currentStatus) {
        case 'hadir':
          notes = (i % 3 == 0) ? 'Tepat waktu' : 'Hadir pukul ${7 + (i % 2)}:${30 + (i % 30)}';
          break;
        case 'sakit':
          notes = 'Surat dokter diterima via WhatsApp';
          break;
        case 'izin':
          notes = (i % 2 == 0) ? 'Izin keluarga' : 'Mengikuti lomba di sekolah lain';
          break;
        case 'alpha':
          notes = 'Tidak ada keterangan';
          break;
        default:
          notes = '';
      }

      mockData.add({
        'date': date,
        'status': currentStatus,
        'notes': notes,
      });
    }

    // Sort data berdasarkan tanggal
    mockData.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
    monthlyAttendance.value = mockData;
  }

  void _calculateWeeklyStatistics() {
    final List<Map<String, dynamic>> stats = [];
    
    // Hitung jumlah minggu dalam bulan
    int weeksInMonth = 0;
    DateTime firstDay = DateTime(selectedMonth.value.year, selectedMonth.value.month, 1);
    
    // Mencari hari Senin pertama
    while (firstDay.weekday != DateTime.monday) {
      firstDay = firstDay.add(const Duration(days: 1));
    }
    
    // Menghitung jumlah minggu
    DateTime tempDate = firstDay;
    while (tempDate.month == selectedMonth.value.month) {
      weeksInMonth++;
      tempDate = tempDate.add(const Duration(days: 7));
    }
    
    // Mencegah terlalu sedikit minggu
    weeksInMonth = weeksInMonth < 4 ? 4 : weeksInMonth;

    for (int week = 0; week < weeksInMonth; week++) {
      final Map<String, int> weekStats = {
        'hadir': 0,
        'sakit': 0,
        'izin': 0,
        'alpha': 0,
        'libur': 0,
      };

      // Menentukan rentang tanggal untuk minggu ini
      final int startDay = week * 7 + 1;
      final int endDay = startDay + 6 > 31 ? 31 : startDay + 6;

      for (final attendance in monthlyAttendance) {
        final DateTime date = attendance['date'];
        if (date.day >= startDay && date.day <= endDay && 
            date.month == selectedMonth.value.month) {
          final String status = attendance['status'];
          weekStats[status] = (weekStats[status] ?? 0) + 1;
        }
      }

      stats.add({
        'week': week + 1,
        'stats': weekStats,
      });
    }

    weeklyStats.value = stats;
  }

  void changeMonth(int offset) {
    try {
      final DateTime newMonth = DateTime(
        selectedMonth.value.year,
        selectedMonth.value.month + offset,
        1,
      );
      selectedMonth.value = newMonth;
      loadStudentAttendanceData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengubah bulan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  String formatDate(DateTime date) {
    final List<String> days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    final List<String> months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    // Adjust for weekday indexing (1-7 in Dart, where 1 is Monday)
    String day = days[date.weekday - 1];
    String month = months[date.month - 1];

    return '$day, ${date.day} $month ${date.year}';
  }

  String formatShortDate(DateTime date) {
    final List<String> days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    final List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    
    String day = days[date.weekday % 7]; // Cycling through 0-6
    String month = months[date.month - 1];
    
    return '$day, ${date.day} $month';
  }

  String formatMonthYear(DateTime date) {
    final List<String> months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    String month = months[date.month - 1];
    return '$month ${date.year}';
  }

  Map<String, int> getMonthlySummary() {
    final Map<String, int> summary = {
      'hadir': 0,
      'sakit': 0,
      'izin': 0,
      'alpha': 0,
    };

    for (final attendance in monthlyAttendance) {
      final String status = attendance['status'];
      if (summary.containsKey(status)) {
        summary[status] = (summary[status] ?? 0) + 1;
      }
    }

    return summary;
  }

  double getAttendancePercentage() {
    int totalSchoolDays = 0;
    int presentDays = 0;

    for (final attendance in monthlyAttendance) {
      final String status = attendance['status'];
      if (status != 'libur') {
        totalSchoolDays++;
        if (status == 'hadir') {
          presentDays++;
        }
      }
    }

    if (totalSchoolDays == 0) return 0.0;
    return (presentDays / totalSchoolDays) * 100;
  }

  // Fungsi untuk mengekspor data absensi (future implementation)
  Future<bool> exportAttendanceData() async {
    try {
      // Simulasi proses ekspor data
      await Future.delayed(const Duration(seconds: 2));
      
      Get.snackbar(
        'Sukses',
        'Data absensi berhasil diekspor',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengekspor data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      
      return false;
    }
  }

  // Fungsi untuk mendapatkan warna status
  Color getStatusColor(String status) {
    switch (status) {
      case 'hadir':
        return Colors.green;
      case 'sakit':
        return Colors.orange;
      case 'izin':
        return Colors.blue;
      case 'alpha':
        return const Color(0xFFBE5B50);
      default:
        return Colors.grey;
    }
  }

  // Fungsi untuk menangani filter absensi
  void setAttendanceFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Fungsi untuk menghitung statistik kehadiran
  Map<String, dynamic> getAttendanceStatistics() {
    int totalDays = 0;
    int schoolDays = 0;
    int presentDays = 0;
    int lateDays = 0;
    
    for (final attendance in monthlyAttendance) {
      totalDays++;
      final String status = attendance['status'];
      
      if (status != 'libur') {
        schoolDays++;
        if (status == 'hadir') {
          presentDays++;
          // Cek keterlambatan berdasarkan catatan
          final String notes = attendance['notes'];
          if (notes.contains('Hadir pukul') && !notes.contains('Tepat waktu')) {
            lateDays++;
          }
        }
      }
    }
    
    double attendanceRate = schoolDays > 0 ? (presentDays / schoolDays) * 100 : 0;
    double punctualityRate = presentDays > 0 ? ((presentDays - lateDays) / presentDays) * 100 : 0;
    
    return {
      'totalDays': totalDays,
      'schoolDays': schoolDays,
      'presentDays': presentDays,
      'lateDays': lateDays,
      'attendanceRate': attendanceRate,
      'punctualityRate': punctualityRate,
    };
  }
}