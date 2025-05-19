import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExtracurricularController extends GetxController {
  // Data untuk ekstrakulikuler
  final List<Map<String, dynamic>> extracurriculars = [
    {
      'name': 'Basket',
      'iconPath': 'assets/logo/icons/basket.png',
      'description': 'Ekstrakulikuler basket melatih keterampilan bermain bola basket, meningkatkan kerja sama tim, dan daya tahan fisik. Latihan rutin dilaksanakan setiap hari Senin dan Rabu.',
      'coach': 'Pak Ahmad Fauzi',
      'schedule': 'Senin & Rabu, 15.30 - 17.30',
      'location': 'Lapangan Basket SpenMa',
      'achievements': [
        'Juara 1 Kompetisi Basket Antar SMA Kota, 2023',
        'Juara 2 Kejuaraan Provinsi, 2022'
      ]
    },
    {
      'name': 'Sepak Bola',
      'iconPath': 'assets/logo/icons/football.png',
      'description': 'Ekstrakulikuler sepak bola adalah tempat untuk mengembangkan keterampilan teknis dan taktis dalam bermain sepak bola, serta meningkatkan sportifitas dan kerja sama tim.',
      'coach': 'Pak Budi Santoso',
      'schedule': 'Selasa & Kamis, 15.30 - 17.30',
      'location': 'Lapangan Sepak Bola SpenMa',
      'achievements': [
        'Juara 1 Liga Pelajar Kota, 2023',
        'Semi Finalis Turnamen Regional, 2022'
      ]
    },
    {
      'name': 'Catur',
      'iconPath': 'assets/logo/icons/chess.png',
      'description': 'Ekstrakulikuler catur mengajarkan strategi, kesabaran, dan kemampuan berpikir analitis. Siswa akan belajar berbagai teknik dan taktik bermain catur dari tingkat dasar hingga lanjutan.',
      'coach': 'Ibu Ratna Wijaya',
      'schedule': 'Jumat, 14.00 - 16.00',
      'location': 'Ruang Catur SpenMa',
      'achievements': [
        'Juara 1 Turnamen Catur Pelajar Tingkat Kota, 2023',
        'Juara 2 Kejuaraan Catur Pelajar Provinsi, 2022'
      ]
    },
    {
      'name': 'Musik',
      'iconPath': 'assets/logo/icons/music.png',
      'description': 'Ekstrakulikuler musik memberikan kesempatan bagi siswa untuk mengekspresikan diri melalui berbagai alat musik. Siswa dapat bergabung dengan band sekolah atau ansambel musik klasik.',
      'coach': 'Pak Denny Pratama',
      'schedule': 'Senin & Kamis, 15.00 - 17.00',
      'location': 'Studio Musik SpenMa',
      'achievements': [
        'Juara 1 Festival Band Antar SMA, 2023',
        'Penampil Terbaik di Acara Ulang Tahun Kota, 2022'
      ]
    },
    {
      'name': 'Paskibra',
      'iconPath': 'assets/logo/icons/flag.png',
      'description': 'Ekstrakulikuler Paskibra (Pasukan Pengibar Bendera) melatih kedisiplinan, ketertiban, dan jiwa nasionalisme. Anggota Paskibra bertanggung jawab dalam upacara bendera dan acara formal sekolah.',
      'coach': 'Ibu Maya Kusuma',
      'schedule': 'Rabu & Jumat, 15.00 - 17.00',
      'location': 'Lapangan Upacara SpenMa',
      'achievements': [
        'Juara 1 Lomba Paskibra Tingkat Kota, 2023',
        'Pengibar Bendera Terpilih untuk Upacara Kenegaraan Tingkat Kota, 2022'
      ]
    },
    {
      'name': 'Pramuka',
      'iconPath': 'assets/logo/icons/scout.png',
      'description': 'Ekstrakulikuler Pramuka mengembangkan karakter, kepemimpinan, dan keterampilan bertahan hidup. Kegiatan meliputi perkemahan, navigasi, pertolongan pertama, dan keterampilan kepanduan lainnya.',
      'coach': 'Pak Rudi Hermawan & Ibu Aisyah',
      'schedule': 'Sabtu, 08.00 - 12.00',
      'location': 'Area Pramuka SpenMa',
      'achievements': [
        'Juara Umum Jambore Daerah, 2023',
        'Juara 1 Lomba Pionering Tingkat Provinsi, 2022'
      ]
    },
    {
      'name': 'Tari',
      'iconPath': 'assets/logo/icons/dance.png',
      'description': 'Ekstrakulikuler tari melestarikan budaya tari tradisional dan juga memperkenalkan tari modern. Siswa akan belajar berbagai gerakan tari dan tampil di berbagai acara sekolah dan kompetisi.',
      'coach': 'Ibu Dewi Anggraini',
      'schedule': 'Selasa & Jumat, 15.00 - 17.00',
      'location': 'Aula Seni SpenMa',
      'achievements': [
        'Juara 1 Festival Tari Daerah, 2023',
        'Penampil di Acara Kebudayaan Tingkat Provinsi, 2022'
      ]
    },
    {
      'name': 'Banjari',
      'iconPath': 'assets/logo/icons/banjari.png',
      'description': 'Ekstrakulikuler Banjari fokus pada seni musik islami dengan menggunakan alat musik rebana. Anggota belajar memainkan rebana dan melantunkan shalawat dalam harmoni yang indah.',
      'coach': 'Ustadz Farid',
      'schedule': 'Kamis, 15.30 - 17.30',
      'location': 'Mushola SpenMa',
      'achievements': [
        'Juara 1 Festival Banjari Tingkat Kota, 2023',
        'Tampil dalam Perayaan Maulid Nabi Tingkat Kota, 2022'
      ]
    },
    {
      'name': 'Pencak Silat',
      'iconPath': 'assets/logo/icons/silat.png',
      'description': 'Ekstrakulikuler Pencak Silat mengajarkan teknik bela diri tradisional Indonesia, disiplin diri, dan ketahanan fisik. Siswa berlatih teknik dasar hingga lanjutan.',
      'coach': 'Pak Hendra Wijaya',
      'schedule': 'Rabu & Sabtu, 15.00 - 17.00',
      'location': 'Arena Beladiri SpenMa',
      'achievements': [
        'Juara 1 Kejuaraan Silat Pelajar Tingkat Provinsi kategori Tunggal, 2023',
        'Juara 2 Kejuaraan Silat antar SMA kategori Beregu, 2022'
      ]
    },
    {
      'name': 'Karawitan',
      'iconPath': 'assets/logo/icons/gamelan.png',
      'description': 'Ekstrakulikuler Karawitan memperkenalkan siswa pada seni musik gamelan tradisional. Siswa belajar memainkan berbagai instrumen gamelan dan mempelajari lagu-lagu tradisional.',
      'coach': 'Pak Sutrisno',
      'schedule': 'Senin & Jumat, 15.00 - 17.00',
      'location': 'Ruang Gamelan SpenMa',
      'achievements': [
        'Juara 1 Festival Karawitan Pelajar Tingkat Kota, 2023',
        'Tampil dalam Acara Budaya Tingkat Provinsi, 2022'
      ]
    },
  ];

  // Method untuk menampilkan detail ekstrakulikuler dengan dialog yang lebih modern
  void showDetailDialog(BuildContext context, Map<String, dynamic> extracurricular) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with gradient
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFBE5B50),
                        const Color(0xFFD77A70),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Icon in a circular white container
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        // Removed color property to show original icon colors
                        child: Image.asset(
                          extracurricular['iconPath'],
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          extracurricular['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Close button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Content in scrollable area
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Description section with card
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: const Color(0xFFEEEEEE),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF053158),
                                      size: 18,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Tentang Ekstrakulikuler",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF053158),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  extracurricular['description'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Info items with modern design
                          const Text(
                            "Informasi Kegiatan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF053158),
                            ),
                          ),
                          const SizedBox(height: 15),
                          
                          _buildModernInfoItem(
                            icon: Icons.person,
                            iconColor: const Color(0xFF5B67CA),
                            title: "Pembina",
                            value: extracurricular['coach'],
                          ),
                          _buildModernInfoItem(
                            icon: Icons.access_time,
                            iconColor: const Color(0xFFFF8C42),
                            title: "Jadwal",
                            value: extracurricular['schedule'],
                          ),
                          _buildModernInfoItem(
                            icon: Icons.location_on,
                            iconColor: const Color(0xFFE63E6D),
                            title: "Lokasi",
                            value: extracurricular['location'],
                          ),
                          
                          const SizedBox(height: 25),
                          
                          // Achievements with badges
                          const Text(
                            "Prestasi",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF053158),
                            ),
                          ),
                          const SizedBox(height: 15),
                          
                          // Modern achievement list
                          ...extracurricular['achievements'].map<Widget>((achievement) => 
                            Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFF5E5C4),
                                    const Color(0xFFF5E5C4).withOpacity(0.7),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFF5E5C4).withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFBE5B50),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.emoji_events,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      achievement,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        height: 1.4,
                                        color: Color(0xFF053158),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                          
                          const SizedBox(height: 30),
                          
                          // Join button with gradient
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              onPressed: () {
                                // Tutup dialog
                                Navigator.of(context).pop();
                                // Tampilkan pesan konfirmasi pendaftaran
                                _showConfirmationDialog(context, extracurricular);
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF053158),
                                      const Color(0xFF1A6BBE),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.how_to_reg,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        "Gabung Sekarang",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // Method baru untuk menampilkan dialog konfirmasi pendaftaran
  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> extracurricular) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF39A388).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF39A388),
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Pendaftaran Berhasil!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF053158),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Kamu telah berhasil mendaftar untuk ekstrakulikuler ${extracurricular['name']}. Silakan hubungi ${extracurricular['coach']} untuk informasi lebih lanjut.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                // Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: const Color(0xFF39A388),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.snackbar(
                      "Info", 
                      "Jadwal kegiatan: ${extracurricular['schedule']}",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                      colorText: const Color(0xFF053158),
                      margin: const EdgeInsets.all(15),
                      borderRadius: 10,
                      duration: const Duration(seconds: 3),
                    );
                  },
                  child: const Text(
                    "Tutup",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // Helper method untuk membuat item informasi dengan desain modern
  Widget _buildModernInfoItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}