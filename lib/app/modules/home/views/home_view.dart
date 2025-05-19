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
      body: SafeArea(
        bottom: false, // Handle bottom safe area manually
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
                        // AppBar Row
                        Row(
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
                                  Image.asset('assets/logo/icons/educorelogo.png', width: 35, height: 35),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "EduCore SpenMa",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage('assets/logo/images/profil.png'),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          "Selamat Datang!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Obx(() => Text(
                              "Hai ${controller.userName.value}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            )),
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
                      borderRadius: BorderRadius.circular(16),
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
              
              // Rest of your content with padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Statistics Card
                    Container(
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
                    const SizedBox(height: 30),
                    
                    // Krida Bhakti Sabha text - Kept as original
                    const Text(
                      "Krida Bhakti Satria Hanoraga...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Modified: Menu icons row - Increased height and added spacing
                    Container(
                      height: 140, // Increased height for larger icons
                      margin: const EdgeInsets.only(bottom: 15),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.menuItems.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => controller.onMenuItemTap(index),
                          child: _buildIconMenu(
                            controller.menuItems[index]['title'],
                            controller.menuItems[index]['icon'],
                            // Use the requested colors for menu items
                            index % 2 == 0 ? const Color(0xFFBE5B50) : const Color(0xFFF5E5C4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40), // Increased spacing
                    
                    // Siswa Berprestasi section
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
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
                    const SizedBox(height: 20),
                    
                    // Student achievement cards
                    Obx(() => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          controller.topStudents.length,
                          (index) => GestureDetector(
                            onTap: () => controller.viewStudentDetails(index),
                            child: _buildStudentCard(
                              controller.topStudents[index]['name'],
                              controller.topStudents[index]['class'],
                              controller.topStudents[index]['rating'],
                            ),
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 80), // Bottom spacing for navigation bar
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Obx(() => Container(
        height: 60, // Reduced height to prevent overflow
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.language, controller.currentNavIndex.value == 0, 0),
              _buildNavItem(Icons.description_outlined, controller.currentNavIndex.value == 1, 1),
              const SizedBox(width: 40), // Space for center button
              _buildNavItem(Icons.edit_outlined, controller.currentNavIndex.value == 2, 2),
              _buildNavItem(Icons.table_chart_outlined, controller.currentNavIndex.value == 3, 3),
            ],
          ),
        ),
      )),
      
      // Floating Home Button
      floatingActionButton: GestureDetector(
        onTap: () => controller.changeNavIndex(0), // Set to home
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF053158),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF053158).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.home,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // New method: Build the Drawer with user information and menu items
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
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo/images/profil.png'),
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
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.code,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(width: 3),
                            Text(
                              "VS Code Only",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  // Helper method to build navigation bar items
  Widget _buildNavItem(IconData icon, bool isActive, int index) {
    return GestureDetector(
      onTap: () => controller.changeNavIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF053158).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isActive ? const Color(0xFF053158) : Colors.grey,
          size: 26,
        ),
      ),
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

  // Modified: Helper method to build icon menu items - increased size and added spacing
  Widget _buildIconMenu(String title, String iconPath, Color bgColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // Increased horizontal spacing
      width: 90, // Increased width for larger menu items
      child: Column(
        mainAxisSize: MainAxisSize.min, // Only take needed space
        children: [
          Container(
            width: 85, // Increased width of icon container
            height: 85, // Increased height of icon container
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(18), // Slightly larger corner radius
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.4), // Slightly stronger shadow
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width: 45, // Increased icon size
                height: 45, // Increased icon size
              ),
            ),
          ),
          const SizedBox(height: 8), // Slightly more space between icon and text
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13, // Slightly larger font
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // Helper method to build student achievement cards
  Widget _buildStudentCard(String name, String kelas, double rating) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFBE5B50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBE5B50).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage('assets/logo/images/barru.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
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
                      'assets/logo/icons/medal.png',
                      width: 28,
                      height: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
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