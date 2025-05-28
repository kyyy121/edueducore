import 'package:flutter/material.dart'; // Tambahkan import ini
import 'package:get/get.dart';

class NotifikasiController extends GetxController {
  // Observable untuk index navigasi
  var currentNavIndex = 2.obs; // Index 2 untuk notifikasi

  // Observable untuk notifikasi
  var notifications = <Map<String, dynamic>>[].obs;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  // Load sample notifications
  void loadNotifications() {
    notifications.value = [
      {
        'id': 1,
        'title': 'Pengumuman Ujian Tengah Semester',
        'message': 'Ujian Tengah Semester akan dilaksanakan pada tanggal 15-20 Januari 2025. Harap persiapkan diri dengan baik.',
        'type': 'announcement',
        'time': '2 jam yang lalu',
        'isRead': false,
        'icon': 'assets/logo/icons/announcement.png',
        'priority': 'high'
      },
      {
        'id': 2,
        'title': 'Pemberitahuan Libur Nasional',
        'message': 'Sekolah akan libur pada tanggal 17 Januari 2025 dalam rangka Hari Raya Nyepi.',
        'type': 'holiday',
        'time': '5 jam yang lalu',
        'isRead': true,
        'icon': 'assets/logo/icons/calendar.png',
        'priority': 'medium'
      },
      {
        'id': 3,
        'title': 'Prestasi Siswa Berprestasi',
        'message': 'Selamat kepada Ahmad Fauzi kelas XII-A yang meraih juara 1 dalam Olimpiade Matematika tingkat provinsi.',
        'type': 'achievement',
        'time': '1 hari yang lalu',
        'isRead': false,
        'icon': 'assets/logo/icons/medal.png',
        'priority': 'medium'
      },
      {
        'id': 4,
        'title': 'Reminder Pembayaran SPP',
        'message': 'Jangan lupa untuk melakukan pembayaran SPP bulan Januari sebelum tanggal 25.',
        'type': 'payment',
        'time': '2 hari yang lalu',
        'isRead': true,
        'icon': 'assets/logo/icons/payment.png',
        'priority': 'high'
      },
      {
        'id': 5,
        'title': 'Kegiatan Ekstrakurikuler',
        'message': 'Pendaftaran ekstrakurikuler semester genap dibuka mulai tanggal 20 Januari 2025.',
        'type': 'activity',
        'time': '3 hari yang lalu',
        'isRead': false,
        'icon': 'assets/logo/icons/activity.png',
        'priority': 'low'
      },
      {
        'id': 6,
        'title': 'Update Jadwal Pelajaran',
        'message': 'Terjadi perubahan jadwal pelajaran Matematika dari hari Senin pindah ke hari Selasa.',
        'type': 'schedule',
        'time': '4 hari yang lalu',
        'isRead': true,
        'icon': 'assets/logo/icons/schedule.png',
        'priority': 'medium'
      },
      {
        'id': 7,
        'title': 'Lomba Karya Tulis Ilmiah',
        'message': 'Dibuka pendaftaran lomba karya tulis ilmiah tingkat SMA se-Jawa Timur. Deadline 30 Januari 2025.',
        'type': 'competition',
        'time': '5 hari yang lalu',
        'isRead': false,
        'icon': 'assets/logo/icons/competition.png',
        'priority': 'medium'
      },
    ];

    // Hitung notifikasi yang belum dibaca
    updateUnreadCount();
  }

  // Update jumlah notifikasi yang belum dibaca
  void updateUnreadCount() {
    unreadCount.value = notifications.where((notif) => !notif['isRead']).length;
  }

  // Mark notification as read
  void markAsRead(int id) {
    int index = notifications.indexWhere((notif) => notif['id'] == id);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
      updateUnreadCount();
    }
  }

  // Mark all notifications as read
  void markAllAsRead() {
    for (int i = 0; i < notifications.length; i++) {
      notifications[i]['isRead'] = true;
    }
    notifications.refresh();
    updateUnreadCount();
  }

  // Delete notification
  void deleteNotification(int id) {
    notifications.removeWhere((notif) => notif['id'] == id);
    updateUnreadCount();
  }

  // Clear all notifications
  void clearAllNotifications() {
    notifications.clear();
    updateUnreadCount();
  }

  // Get notification color based on priority
  Color getNotificationColor(String priority) {
    switch (priority) {
      case 'high':
        return const Color(0xFFE53E3E); // Red
      case 'medium':
        return const Color(0xFFBE5B50); // Orange-red
      case 'low':
        return const Color(0xFF38A169); // Green
      default:
        return const Color(0xFFBE5B50);
    }
  }

  // Get notification type color
  Color getNotificationTypeColor(String type) {
    switch (type) {
      case 'announcement':
        return const Color(0xFFBE5B50);
      case 'holiday':
        return const Color(0xFF38A169);
      case 'achievement':
        return const Color(0xFFD69E2E);
      case 'payment':
        return const Color(0xFFE53E3E);
      case 'activity':
        return const Color(0xFF3182CE);
      case 'schedule':
        return const Color(0xFF805AD5);
      case 'competition':
        return const Color(0xFFD53F8C);
      default:
        return const Color(0xFFBE5B50);
    }
  }

  // Navigation methods
  void changeNavIndex(int index) {
    currentNavIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed('/home');
        break;
      case 1:
        Get.offNamed('/berita');
        break;
      case 2:
        // Already on notification page
        break;
    }
  }

  // Refresh notifications
  Future<void> refreshNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    loadNotifications();
  }

  // Filter notifications by type
  List<Map<String, dynamic>> getNotificationsByType(String type) {
    return notifications.where((notif) => notif['type'] == type).toList();
  }

  // Get unread notifications
  List<Map<String, dynamic>> getUnreadNotifications() {
    return notifications.where((notif) => !notif['isRead']).toList();
  }
}