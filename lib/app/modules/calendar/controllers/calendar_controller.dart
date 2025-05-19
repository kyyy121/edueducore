import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarController extends GetxController {
  // Calendar variables
  final selectedDay = DateTime.now().obs;
  final focusedDay = DateTime.now().obs;
  final calendarFormat = CalendarFormat.month.obs;

  // Reactive Events Map
  final events = <DateTime, List<Map<String, dynamic>>>{}.obs;

  // Selected events for the day
  final selectedEvents = <Map<String, dynamic>>[].obs;

  // For header display
  final selectedMonth = ''.obs;
  final selectedYear = ''.obs;
  final totalEvents = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting('id_ID', null);
    _loadEvents();
    updateSelectedMonthYear(focusedDay.value);
    selectedEvents.value = getEventsForDay(selectedDay.value);
    _calculateTotalEvents();
  }

  void _loadEvents() {
    final now = DateTime.now();

    final eventsList = [
      {
        'date': DateTime(now.year, now.month, 5),
        'title': 'HUT SMPN 5 Malang',
        'startTime': '08:00',
        'endTime': '15:00',
        'location': 'Aula Sekolah',
        'category': 'Perayaan',
        'description': 'Perayaan ulang tahun SMPN 5 Malang yang ke-65 dengan berbagai acara dan penampilan dari siswa.'
      },
      {
        'date': DateTime(now.year, now.month, 10),
        'title': 'Lomba Karya Ilmiah',
        'startTime': '09:00',
        'endTime': '12:00',
        'location': 'Ruang Multimedia',
        'category': 'Lomba',
        'description': 'Lomba karya ilmiah tingkat sekolah dengan tema "Inovasi untuk Lingkungan Berkelanjutan".'
      },
      {
        'date': DateTime(now.year, now.month, 12),
        'title': 'Rapat Wali Murid',
        'startTime': '13:00',
        'endTime': '15:00',
        'location': 'Ruang Pertemuan',
        'category': 'Rapat',
        'description': 'Rapat koordinasi dengan wali murid mengenai persiapan ujian akhir semester.'
      },
      {
        'date': DateTime(now.year, now.month, 17),
        'title': 'Upacara Hari Kemerdekaan',
        'startTime': '07:30',
        'endTime': '09:00',
        'location': 'Lapangan Sekolah',
        'category': 'Upacara',
        'description': 'Upacara peringatan Hari Kemerdekaan Republik Indonesia.'
      },
      {
        'date': DateTime(now.year, now.month, 20),
        'title': 'Ujian Tengah Semester',
        'startTime': '07:30',
        'endTime': '12:30',
        'location': 'Ruang Kelas',
        'category': 'Akademik',
        'description': 'Ujian Tengah Semester untuk semua mata pelajaran.'
      },
      {
        'date': DateTime(now.year, now.month, 21),
        'title': 'Ujian Tengah Semester',
        'startTime': '07:30',
        'endTime': '12:30',
        'location': 'Ruang Kelas',
        'category': 'Akademik',
        'description': 'Ujian Tengah Semester untuk semua mata pelajaran.'
      },
      {
        'date': DateTime(now.year, now.month, 22),
        'title': 'Ujian Tengah Semester',
        'startTime': '07:30',
        'endTime': '12:30',
        'location': 'Ruang Kelas',
        'category': 'Akademik',
        'description': 'Ujian Tengah Semester untuk semua mata pelajaran.'
      },
      {
        'date': DateTime(now.year, now.month, 25),
        'title': 'Lomba Kebersihan Kelas',
        'startTime': '09:00',
        'endTime': '11:00',
        'location': 'Seluruh Kelas',
        'category': 'Lomba',
        'description': 'Lomba kebersihan dan kerapian kelas antar kelas di sekolah.'
      },
      {
        'date': DateTime(now.year, now.month, 28),
        'title': 'Pengajian Bulanan',
        'startTime': '13:00',
        'endTime': '15:00',
        'location': 'Mushola Sekolah',
        'category': 'Keagamaan',
        'description': 'Pengajian rutin bulanan untuk siswa dan guru.'
      },
    ];

    for (var event in eventsList) {
      final date = _dateOnly(event['date'] as DateTime);
      if (!events.containsKey(date)) {
        events[date] = [];
      }
      events[date]!.add(event);
    }
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    final dateOnly = _dateOnly(day);
    return events[dateOnly] ?? [];
  }

  DateTime _dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    selectedEvents.value = getEventsForDay(selectedDay);
  }

  void updateSelectedMonthYear(DateTime date) {
    selectedMonth.value = DateFormat('MMMM', 'id_ID').format(date);
    selectedYear.value = DateFormat('yyyy').format(date);
    _calculateTotalEvents();
  }

  void _calculateTotalEvents() {
    int total = 0;
    final firstDay = DateTime(focusedDay.value.year, focusedDay.value.month, 1);
    final lastDay = DateTime(focusedDay.value.year, focusedDay.value.month + 1, 0);

    for (DateTime day = firstDay;
        day.isBefore(lastDay.add(const Duration(days: 1)));
        day = day.add(const Duration(days: 1))) {
      final date = _dateOnly(day);
      total += events[date]?.length ?? 0;
    }

    totalEvents.value = total;
  }

  void searchEvents() {
    Get.dialog(
      AlertDialog(
        title: const Text('Fitur Pencarian'),
        content: const Text('Fitur pencarian kegiatan akan tersedia pada versi mendatang.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void viewAllEvents() {
    Get.dialog(
      AlertDialog(
        title: const Text('Semua Kegiatan'),
        content: const Text('Daftar lengkap kegiatan akan tersedia pada versi mendatang.'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Tutup')),
        ],
      ),
    );
  }

  void viewEventDetails(Map<String, dynamic> event) {
    Get.dialog(
      AlertDialog(
        title: Text(event['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(Icons.calendar_today, 'Tanggal', DateFormat('d MMMM yyyy', 'id_ID').format(event['date'])),
            _buildDetailRow(Icons.access_time, 'Waktu', '${event['startTime']} - ${event['endTime']}'),
            _buildDetailRow(Icons.location_on, 'Lokasi', event['location']),
            _buildDetailRow(Icons.category, 'Kategori', event['category']),
            const SizedBox(height: 12),
            const Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(event['description']),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Tutup')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              _showReminderConfirmation();
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBE5B50)),
            child: const Text('Ingatkan Saya'),
          ),
        ],
      ),
    );
  }

  void _showReminderConfirmation() {
    Get.snackbar(
      'Pengingat Ditambahkan',
      'Anda akan diingatkan tentang kegiatan ini.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF053158),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFFBE5B50)),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}
