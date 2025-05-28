import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/attendance_controller.dart';
import 'package:intl/intl.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: const Color(0xFFF5E5C4),
              elevation: 0,
              pinned: true,
              floating: false,
              snap: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              title: const Text(
                "Kehadiran Siswa",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
              
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5E5C4),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60), // Space for AppBar
                      child: _buildHeaderContent(),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Attendance Form
              _buildAttendanceForm(context),
              
              // Attendance History
              _buildAttendanceHistory(),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeaderContent() {
    return Column(
      children: [
        // Date display
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hari ini",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Obx(() => Text(
                    DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(controller.currentDate.value),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.black,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Obx(() => Text(
                      controller.currentTime.value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Student info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    controller.studentName.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
                  const SizedBox(height: 2),
                  Obx(() => Text(
                    "${controller.studentClass.value} • NIS: ${controller.studentNIS.value}",
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildAttendanceForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBE5B50),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "Form Kehadiran",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "Silakan pilih status kehadiran hari ini:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Attendance Status Selection
                  Obx(() => Column(
                    children: [
                      _buildAttendanceOption(
                        title: "Hadir",
                        description: "Saya hadir di sekolah",
                        icon: Icons.check_circle,
                        color: const Color(0xFF4CAF50),
                        value: "H",
                        isSelected: controller.selectedAttendanceType.value == "H",
                      ),
                      const SizedBox(height: 12),
                      _buildAttendanceOption(
                        title: "Sakit",
                        description: "Saya tidak dapat hadir karena sakit",
                        icon: Icons.healing,
                        color: const Color(0xFFFF9800),
                        value: "S",
                        isSelected: controller.selectedAttendanceType.value == "S",
                      ),
                      const SizedBox(height: 12),
                      _buildAttendanceOption(
                        title: "Izin",
                        description: "Saya tidak dapat hadir dengan izin",
                        icon: Icons.event_busy,
                        color: const Color(0xFF2196F3),
                        value: "I",
                        isSelected: controller.selectedAttendanceType.value == "I",
                      ),
                    ],
                  )),
                  
                  // Conditional Fields based on selected status
                  Obx(() {
                    if (controller.selectedAttendanceType.value == "H") {
                      return const SizedBox(); // No additional fields for present status
                    } else {
                      // Fields for sick or leave
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 20),
                          
                          // Duration selection
                          const Text(
                            "Durasi:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                isExpanded: true,
                                value: controller.leaveDuration.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    controller.changeLeaveDuration(value);
                                  }
                                },
                                items: [1, 2, 3, 4, 5].map((int duration) {
                                  return DropdownMenuItem<int>(
                                    value: duration,
                                    child: Text("$duration Hari"),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Reason field
                          const Text(
                            "Alasan:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            maxLines: 3,
                            onChanged: controller.setLeaveReason,
                            decoration: InputDecoration(
                              hintText: controller.selectedAttendanceType.value == "S" 
                                  ? "Tuliskan jenis penyakit dan keluhan" 
                                  : "Tuliskan alasan izin secara detail",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: Color(0xFFBE5B50), width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          // Attachment option
                          InkWell(
                            onTap: () {
                              // Add attachment logic
                              controller.addAttachment("attachment.jpg");
                              Get.snackbar(
                                "Sukses",
                                "Berkas berhasil dilampirkan",
                                backgroundColor: const Color(0xFF053158),
                                colorText: Colors.white,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade50,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.attach_file,
                                    color: Color(0xFF053158),
                                    size: 22,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      controller.selectedAttendanceType.value == "S"
                                          ? "Lampirkan surat dokter (opsional)"
                                          : "Lampirkan dokumen pendukung (opsional)",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Obx(() => controller.attachmentPath.value.isNotEmpty 
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF4CAF50),
                                          size: 20,
                                        )
                                      : const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  
                  const SizedBox(height: 25),
                  
                  // Submit button
                  ElevatedButton(
                    onPressed: () async {
                      // Submit form logic
                      final result = await controller.submitAttendance();
                      if (result) {
                        _showSuccessDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF053158),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Obx(() => Text(
                        controller.selectedAttendanceType.value == "H"
                            ? "Konfirmasi Kehadiran"
                            : controller.selectedAttendanceType.value == "S"
                                ? "Kirim Laporan Sakit"
                                : "Ajukan Izin",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAttendanceOption({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String value,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => controller.selectAttendanceType(value),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isSelected ? color : Colors.grey,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? color : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? color : Colors.grey,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
  
  void _showSuccessDialog(BuildContext context) {
    String title = "Berhasil!";
    String message = "";
    
    switch (controller.selectedAttendanceType.value) {
      case "H":
        message = "Kehadiran Anda telah tercatat";
        break;
      case "S":
        message = "Laporan sakit Anda telah terkirim";
        break;
      case "I":
        message = "Pengajuan izin Anda telah terkirim";
        break;
      default:
        message = "Data Anda telah terkirim";
    }
    
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF4CAF50),
              size: 60,
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Data akan diproses oleh wali kelas. Silahkan cek status kehadiran secara berkala.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.loadTodayAttendance(); // Refresh attendance status
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF053158),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAttendanceHistory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBE5B50),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Riwayat Kehadiran",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => controller.viewAttendanceHistory(),
                child: const Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Color(0xFFBE5B50),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Obx(() => Column(
            children: controller.attendanceHistory
                .map((history) => _buildHistoryItem(
                      date: history['date'],
                      status: history['status'],
                      description: history['description'],
                    ))
                .toList(),
          )),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem({
    required String date, 
    required String status, 
    required String description
  }) {
    Color statusColor;
    IconData statusIcon;
    
    switch (status) {
      case 'H':
        statusColor = const Color(0xFF4CAF50);
        statusIcon = Icons.check_circle;
        break;
      case 'I':
        statusColor = const Color(0xFF2196F3);
        statusIcon = Icons.event_busy;
        break;
      case 'S':
        statusColor = const Color(0xFFFF9800);
        statusIcon = Icons.healing;
        break;
      case 'A':
        statusColor = const Color(0xFFE53935);
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}