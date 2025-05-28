import 'package:get/get.dart';

class StartingController extends GetxController {
  // Observable untuk data kehadiran per minggu
  var weeklyAttendanceData = <Map<String, dynamic>>[].obs;
  var currentWeek = 1.obs;
  var userName = 'Nama Siswa'.obs;
  var totalPresent = 0.obs;
  var totalPermission = 0.obs;
  var totalSick = 0.obs;
  var totalAbsent = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadAttendanceData();
  }
  
  void loadAttendanceData() {
    // Data dummy untuk 4 minggu kehadiran
    weeklyAttendanceData.value = [
      {
        'week': 1,
        'title': 'Minggu 1',
        'present': 5,
        'permission': 1,
        'sick': 0,
        'absent': 0,
        'details': [
          {'day': 'Senin', 'status': 'Hadir', 'time': '07:15'},
          {'day': 'Selasa', 'status': 'Hadir', 'time': '07:20'},
          {'day': 'Rabu', 'status': 'Hadir', 'time': '07:10'},
          {'day': 'Kamis', 'status': 'Izin', 'time': '-'},
          {'day': 'Jumat', 'status': 'Hadir', 'time': '07:25'},
          {'day': 'Sabtu', 'status': 'Hadir', 'time': '07:18'},
        ]
      },
      {
        'week': 2,
        'title': 'Minggu 2',
        'present': 4,
        'permission': 0,
        'sick': 1,
        'absent': 1,
        'details': [
          {'day': 'Senin', 'status': 'Hadir', 'time': '07:12'},
          {'day': 'Selasa', 'status': 'Hadir', 'time': '07:30'},
          {'day': 'Rabu', 'status': 'Sakit', 'time': '-'},
          {'day': 'Kamis', 'status': 'Hadir', 'time': '07:08'},
          {'day': 'Jumat', 'status': 'Alpha', 'time': '-'},
          {'day': 'Sabtu', 'status': 'Hadir', 'time': '07:22'},
        ]
      },
      {
        'week': 3,
        'title': 'Minggu 3',
        'present': 6,
        'permission': 0,
        'sick': 0,
        'absent': 0,
        'details': [
          {'day': 'Senin', 'status': 'Hadir', 'time': '07:05'},
          {'day': 'Selasa', 'status': 'Hadir', 'time': '07:15'},
          {'day': 'Rabu', 'status': 'Hadir', 'time': '07:18'},
          {'day': 'Kamis', 'status': 'Hadir', 'time': '07:12'},
          {'day': 'Jumat', 'status': 'Hadir', 'time': '07:20'},
          {'day': 'Sabtu', 'status': 'Hadir', 'time': '07:10'},
        ]
      },
      {
        'week': 4,
        'title': 'Minggu 4',
        'present': 3,
        'permission': 2,
        'sick': 0,
        'absent': 1,
        'details': [
          {'day': 'Senin', 'status': 'Hadir', 'time': '07:25'},
          {'day': 'Selasa', 'status': 'Izin', 'time': '-'},
          {'day': 'Rabu', 'status': 'Hadir', 'time': '07:15'},
          {'day': 'Kamis', 'status': 'Izin', 'time': '-'},
          {'day': 'Jumat', 'status': 'Alpha', 'time': '-'},
          {'day': 'Sabtu', 'status': 'Hadir', 'time': '07:30'},
        ]
      },
    ];
    
    calculateTotalStats();
  }
  
  void calculateTotalStats() {
    int present = 0, permission = 0, sick = 0, absent = 0;
    
    for (var week in weeklyAttendanceData) {
      present += week['present'] as int;
      permission += week['permission'] as int;
      sick += week['sick'] as int;
      absent += week['absent'] as int;
    }
    
    totalPresent.value = present;
    totalPermission.value = permission;
    totalSick.value = sick;
    totalAbsent.value = absent;
  }
  
  void selectWeek(int week) {
    currentWeek.value = week;
  }
  
  // Mendapatkan data minggu yang dipilih
  Map<String, dynamic> getCurrentWeekData() {
    return weeklyAttendanceData.firstWhere(
      (week) => week['week'] == currentWeek.value,
      orElse: () => weeklyAttendanceData.first,
    );
  }
  
  // Mendapatkan warna berdasarkan status
  String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'hadir':
        return '0xFF4CAF50'; // Green
      case 'izin':
        return '0xFFFF9800'; // Orange
      case 'sakit':
        return '0xFF2196F3'; // Blue
      case 'alpha':
        return '0xFFF44336'; // Red
      default:
        return '0xFF9E9E9E'; // Grey
    }
  }
  
  void goBack() {
    Get.back();
  }
}