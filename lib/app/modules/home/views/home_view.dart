import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // Background color
      drawer: _buildDrawer(), // Add the drawer here
      // Menghapus SafeArea dan mewarnai status bar secara otomatis
      extendBodyBehindAppBar: true, // Penting: Memungkinkan body diperpanjang ke belakang AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0), // AppBar hanya untuk mengatur status bar
        child: AppBar(
          backgroundColor: const Color(0xFFBE5B50), // Warna header yang sama
          elevation: 0,
          toolbarHeight: 0,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(), // Changed to ClampingScrollPhysics to prevent overscroll
          child: Container(
            // This ensures content fills at least the screen height minus bottom nav
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 70, // Subtract bottom nav height
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header and Search Bar (using Stack)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Header Card (enlarged)
                    Container(
                      height: 220,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBE5B50),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(28),
                          bottomRight: Radius.circular(28),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Spasi untuk ketinggian status bar
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          
                          // AppBar Row
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                // Changed to Builder to get the correct context for opening the drawer
                                Builder(
                                  builder: (context) => IconButton(
                                    icon: const Icon(Icons.menu, color: Colors.white, size: 24),
                                    onPressed: () => Scaffold.of(context).openDrawer(),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 0.01),
                                      const Text(
                                        "EduCore",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.navigateToProfile,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 1),
                                    ),
                                    child: const CircleAvatar(
                                      radius: 20,
                                      backgroundImage: AssetImage('assets/logo/images/profil2.png'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Posisi teks greeting diubah ke tengah
                          // Menggunakan Expanded untuk mendorong konten ke tengah
                            Expanded(                           
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Now using Obx for greeting which will change based on time of day
                                  Obx(() => Text(
                                        controller.greeting.value,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18, // Sedikit lebih besar
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )),
                                  const SizedBox(height: 10),
                                  Obx(() => Text(
                                        "Hai ${controller.userName.value}",
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      )),
                                ],
                              ),                           
                            ),
                          
                          // Ruang kosong di bawah untuk search bar
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),

                    // Floating Search Bar
                    Positioned(
                      bottom: -28,
                      left: 20,
                      right: 20,
                      child: Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Cari sesuatu...",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50), // Space after search bar
                
                // Updated: Enhanced Image Slideshow with PageView and swipe gesture support
                _buildEnhancedImageSlideshow(),
                
                const SizedBox(height: 30),
                
                // Statistics Card - Now with horizontal padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5E5C4),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top stats text with circle indicator
                        Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: const BoxDecoration(
                                color: Color(0xFF053158),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.trending_up,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Starting Kamu",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "Bulan Ini",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Bar chart
                        Obx(() => SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: controller.weeklyStats.map((stat) => 
                              _buildBar(stat, const Color(0xFFBE5B50))
                            ).toList(),
                          ),
                        )),
                        const SizedBox(height: 24),
                        
                        // Lihat Detail button
                        Center(
                          child: GestureDetector(
                            onTap: controller.viewPerformanceDetails,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF053158),
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                "Lihat Detail",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Krida Bhakti Sabha text - With padding
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Krida Bhakti Satria Hanoraga...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Menu icons row - MODIFIED: Removed horizontal padding to make it full width
                Container(
                  height: 140, // Increased height for larger icons
                  margin: const EdgeInsets.only(bottom: 0.01),
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15), // Added padding to maintain spacing from edges
                    itemCount: controller.menuItems.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => controller.onMenuItemTap(index),
                      child: _buildIconMenu(
                        controller.menuItems[index]['title'],
                        controller.menuItems[index]['icon'],
                        // Use the color from the controller
                        Color(controller.menuItems[index]['color']),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40), // Increased spacing
                
                // Siswa Berprestasi section - With padding
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBE5B50),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Siswa Berprestasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                
                // Student achievement cards - Fixed to properly display student information
                SizedBox(
                  height: 280, // Set fixed height for the horizontal list
                  width: double.infinity,
                  child: Obx(() => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20), // Added padding to maintain spacing from edges
                    itemCount: controller.topStudents.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => controller.viewStudentDetails(index),
                      child: _buildStudentCard(
                        controller.topStudents[index]['name'],
                        controller.topStudents[index]['class'],
                        controller.topStudents[index]['rating'],
                        controller.topStudents[index]['image'] ?? 'assets/logo/images/student_placeholder.jpg', // Use dynamic image or fallback
                      ),
                    ),
                  )),
                ),
                
                // Reduced bottom padding to prevent extra whitespace
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
      
      // UPDATED: New Custom Bottom Navigation Bar
      bottomNavigationBar: Obx(() => Container(
        height: 89, // Increased height for the new design
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF053158), // Dark blue background
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNewNavItem(
                Icons.home_rounded, 
                "Home", 
                controller.currentNavIndex.value == 0, 
                0
              ),
              _buildNewNavItem(
                Icons.newspaper_rounded, 
                "Berita", 
                controller.currentNavIndex.value == 1, 
                1
              ),
              _buildNewNavItem(
                Icons.notifications_rounded, 
                "Notifikasi", 
                controller.currentNavIndex.value == 2, 
                2
              ),
            ],
          ),
        ),
      )),
      
      // Removed floating action button as it's no longer needed
    );
  }

  // Updated: Enhanced Image Slideshow with PageView and swipe support
  Widget _buildEnhancedImageSlideshow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Slideshow container
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: GestureDetector(
              onHorizontalDragUpdate: controller.onSlideSwipe,
              onHorizontalDragEnd: controller.onSlideSwipeEnd,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.slideshowItems.length,
                  onPageChanged: controller.onPageChanged,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.slideshowItems[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image
                        Image.asset(
                          item['imageUrl'],
                          fit: BoxFit.cover,
                        ),
                        
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                        
                        // Title
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          
          // Indicator dots
          Container(
            margin: const EdgeInsets.only(top: 15),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.slideshowItems.length,
                (index) => Obx(() => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.currentSlideIndex.value == index
                        ? const Color(0xFFBE5B50)
                        : Colors.grey.withOpacity(0.3),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewNavItem(IconData icon, String label, bool isActive, int index) {
    return GestureDetector(
      onTap: () => controller.changeNavIndex(index),
      child: Container( // Ganti dari AnimatedContainer ke Container
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon tanpa animasi
            Container(
              height: isActive ? 32 : 24,
              width: isActive ? 32 : 24,
              child: Icon(
                icon,
                color: isActive ? Colors.white : Colors.white54,
                size: isActive ? 28 : 22,
              ),
            ),
            const SizedBox(height: 4),
            // Label tanpa animasi opacity
            Opacity(
              opacity: isActive ? 1.0 : 0.7,
              child: Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white54,
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // Build the Drawer with user information and menu items
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        color: const Color(0xFFF5E5C4), // Light beige background as requested
        child: Column(
          children: [
            // User profile section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFBAAD93), // Taupe color as requested
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo/images/profil2.png'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // User name
                  Obx(() => Text(
                    controller.userName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  const SizedBox(height: 6),
                  
                  // Phone number with VS Code edit indication
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                        controller.userPhone.value.isEmpty ? "+62 8xx-xxxx-xxxx" : controller.userPhone.value,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
            
            // Menu items
            const SizedBox(height: 20),
            _buildDrawerItem(
              icon: Icons.person,
              title: "Akun Saya",
              onTap: () => controller.navigateToMyAccount(),
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: "Pengaturan",
              onTap: () => controller.navigateToSettings(),
            ),
            const Divider(color: Color(0xFFBAAD93), thickness: 1),
            _buildDrawerItem(
              icon: Icons.logout,
              title: "Log Out",
              onTap: () => controller.logout(), // This should navigate to login_view.dart
              isLogout: true,
            ),
            
            // Bottom information
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "EduCore SpenMa v1.0.0",
                style: TextStyle(
                  color: Color(0xFFBAAD93),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build drawer item
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required Function onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? const Color(0xFFBE5B50) : const Color(0xFF053158),
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? const Color(0xFFBE5B50) : Colors.black87,
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          fontSize: 16,
        ),
      ),
      onTap: () => onTap(),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    );
  }

  // Helper method to build bar chart bars
  Widget _buildBar(double height, Color color) {
    return Container(
      width: 28,
      height: 70 * height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }

  // Helper method to build icon menu items - with margin
  Widget _buildIconMenu(String title, String iconPath, Color bgColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 90,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 45,
                height: 45,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // Student card builder to properly display student information
  Widget _buildStudentCard(String name, String kelas, double rating, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white, // Changed background color to white
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container with clip and gradient
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 186, // Reduced height to give more space for text
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Image.asset(
                        'assets/logo/icons/medal2.png',
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Student info card with solid background
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFBE5B50), // Solid background color
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  kelas,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}