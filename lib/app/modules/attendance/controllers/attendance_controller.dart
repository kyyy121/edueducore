import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class AttendanceController extends GetxController {
  // Current date and time variables
  final currentDate = DateTime.now().obs;
  final currentTime = ''.obs;
  
  // Student data
  final studentName = 'Muhammad Zacky'.obs;
  final studentClass = '6G6'.obs;
  final studentNIS = '123456'.obs;
  
  // Current attendance status
  final attendanceStatus = 'H'.obs; // H = Hadir, I = Izin, S = Sakit, A = Alpha
  
  // Selected attendance type for submission
  final selectedAttendanceType = 'H'.obs; // Default to Present (Hadir)
  
  // Form values
  final leaveDuration = 1.obs;
  final leaveReason = ''.obs;
  final attachmentPath = ''.obs;
  
  // Attendance history
  final attendanceHistory = <Map<String, dynamic>>[
    {
      'date': '13 Mei 2025',
      'status': 'H',
      'description': 'Hadir'
    },
    {
      'date': '12 Mei 2025',
      'status': 'H',
      'description': 'Hadir'
    },
    {
      'date': '11 Mei 2025',
      'status': 'S',
      'description': 'Sakit - Demam'
    },
    {
      'date': '10 Mei 2025',
      'status': 'I',
      'description': 'Izin - Acara Keluarga'
    },
  ].obs;
  
  // Timer for updating the current time
  late final Timer _timer;
  
  @override
  void onInit() {
    super.onInit();
    
    // Initialize time update
    updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => updateCurrentTime());
    
    // Load student data (would be from API in real app)
    loadStudentData();
  }
  
  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
  
  // Update current time
  void updateCurrentTime() {
    currentTime.value = DateFormat('HH:mm:ss').format(DateTime.now());
  }
  
  // Load student data (simulate API call)
  void loadStudentData() {
    // This would be replaced with actual API call in real app
    // For now, we'll just use hardcoded values
    studentName.value = 'Muhammad Zacky';
    studentClass.value = '6G6';
    studentNIS.value = '123456';
    
    // Load today's attendance status
    loadTodayAttendance();
  }
  
  // Load today's attendance (simulate API call)
  void loadTodayAttendance() {
    // This would be replaced with actual API call in real app
    // For now, just reset the form and set the default selection to match current status
    selectedAttendanceType.value = attendanceStatus.value;
    leaveReason.value = '';
    attachmentPath.value = '';
    leaveDuration.value = 1;
  }
  
  // Select attendance type
  void selectAttendanceType(String type) {
    selectedAttendanceType.value = type;
    
    // Reset form when changing type
    if (type == 'H') {
      leaveReason.value = '';
      attachmentPath.value = '';
    }
  }
  
  // Change leave duration
  void changeLeaveDuration(int days) {
    leaveDuration.value = days;
  }
  
  // Set leave reason
  void setLeaveReason(String reason) {
    leaveReason.value = reason;
  }
  
  // Add attachment
  void addAttachment(String path) {
    attachmentPath.value = path;
  }
  
  // Submit attendance data
  Future<bool> submitAttendance() async {
    // Validate form for non-present status
    if (selectedAttendanceType.value != 'H' && leaveReason.value.isEmpty) {
      Get.snackbar(
        'Error',
        selectedAttendanceType.value == 'S' 
            ? 'Mohon isi alasan sakit'
            : 'Mohon isi alasan izin',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
      return false;
    }
    
    // Show loading
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // Close loading dialog
    Get.back();
    
    // Update attendance status
    attendanceStatus.value = selectedAttendanceType.value;
    
    // For demonstrating changes in the history:
    // Add to history if not present (since absent/leave records are more important to track)
    if (selectedAttendanceType.value != 'H') {
      String description = selectedAttendanceType.value == 'S' 
          ? 'Sakit - ${leaveReason.value}'
          : 'Izin - ${leaveReason.value}';
          
      final newRecord = {
        'date': DateFormat('d MMMM yyyy', 'id_ID').format(currentDate.value),
        'status': selectedAttendanceType.value,
        'description': description,
      };
      
      // Add to the beginning of the history list
      attendanceHistory.insert(0, newRecord);
    }
    
    // Here we would send the data to backend
    
    // Return success
    return true;
  }
  
  // View detailed attendance history
  void viewAttendanceHistory() {
    Get.snackbar(
      'Info',
      'Fitur riwayat lengkap akan segera hadir',
      backgroundColor: const Color(0xFF053158),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(15),
    );
  }
}