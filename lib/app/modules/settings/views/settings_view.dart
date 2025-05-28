import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFBE5B50),
        elevation: 0,
        title: const Text(
          "Pengaturan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card with User Profile
            Container(
              width: double.infinity,
              color: const Color(0xFFBE5B50),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
              ),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/logo/images/profil.png'),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // User Name
                  Obx(() => Text(
                    controller.userName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(height: 6),

                  // User Level/Role
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Siswa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Settings Sections
            const SizedBox(height: 20),
            _buildSectionTitle("Akun"),
            _buildSettingItem(
              icon: Icons.person_outline,
              title: "Profil Pengguna",
              subtitle: "Ubah informasi profil Anda",
              color: const Color(0xFF053158),
            ),
            _buildSettingItem(
              icon: Icons.lock_outline,
              title: "Keamanan",
              subtitle: "Ubah kata sandi dan pengaturan keamanan",
              color: const Color(0xFF053158),
            ),
            _buildSettingItem(
              icon: Icons.notifications_none_outlined,
              title: "Notifikasi",
              subtitle: "Atur preferensi notifikasi",
              color: const Color(0xFF053158),
              showToggle: true,
            ),

            const SizedBox(height: 10),
            _buildSectionTitle("Tampilan"),
            _buildSettingItem(
              icon: Icons.color_lens_outlined,
              title: "Tema",
              subtitle: "Pilih tema aplikasi",
              color: const Color(0xFFBE5B50),
              showValue: true,
              value: "Terang",
            ),
            _buildSettingItem(
              icon: Icons.font_download_outlined,
              title: "Ukuran Font",
              subtitle: "Ubah ukuran font",
              color: const Color(0xFFBE5B50),
              showValue: true,
              value: "Normal",
            ),
            _buildSettingItem(
              icon: Icons.language_outlined,
              title: "Bahasa",
              subtitle: "Pilih bahasa aplikasi",
              color: const Color(0xFFBE5B50),
              showValue: true,
              value: "Indonesia",
            ),

            const SizedBox(height: 10),
            _buildSectionTitle("Penyimpanan & Data"),
            _buildSettingItem(
              icon: Icons.storage_outlined,
              title: "Manajemen Data",
              subtitle: "Hapus cache dan mengatur data aplikasi",
              color: const Color(0xFF053158),
            ),
            _buildSettingItem(
              icon: Icons.cloud_download_outlined,
              title: "Download Otomatis",
              subtitle: "Download data ketika menggunakan WiFi",
              color: const Color(0xFF053158),
              showToggle: true,
            ),
            _buildSettingItem(
              icon: Icons.sync_outlined,
              title: "Sinkronisasi",
              subtitle: "Sinkronisasi data otomatis",
              color: const Color(0xFF053158),
              showToggle: true,
            ),

            const SizedBox(height: 10),
            _buildSectionTitle("Lainnya"),
            _buildSettingItem(
              icon: Icons.headset_mic_outlined,
              title: "Bantuan & Dukungan",
              subtitle: "FAQ dan panduan penggunaan",
              color: const Color(0xFFBE5B50),
            ),
            _buildSettingItem(
              icon: Icons.info_outline,
              title: "Tentang Aplikasi",
              subtitle: "Versi dan informasi aplikasi",
              color: const Color(0xFFBE5B50),
              showValue: true,
              value: "v1.0.0",
            ),

            const SizedBox(height: 10),
            _buildSettingItem(
              icon: Icons.logout,
              title: "Keluar",
              subtitle: "Keluar dari akun",
              color: Colors.red,
              isDanger: true,
            ),

            const SizedBox(height: 30),
            Center(
              child: Text(
                "EduCore SpenMa v1.0.0",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFBE5B50),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF053158),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    bool isDanger = false,
    bool showToggle = false,
    bool showValue = false,
    String value = "",
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDanger ? Colors.red : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: showToggle
            ? Obx(() => Switch(
                  value: title == "Notifikasi"
                      ? controller.notificationsEnabled.value
                      : title == "Download Otomatis"
                          ? controller.autoDownloadEnabled.value
                          : controller.syncEnabled.value,
                  onChanged: (value) {
                    if (title == "Notifikasi") {
                      controller.toggleNotifications();
                    } else if (title == "Download Otomatis") {
                      controller.toggleAutoDownload();
                    } else {
                      controller.toggleSync();
                    }
                  },
                  activeColor: const Color(0xFFBE5B50),
                ))
            : showValue
                ? Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
      ),
    );
  }
}