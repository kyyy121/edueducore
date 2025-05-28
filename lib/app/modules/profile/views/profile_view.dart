import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // SliverAppBar yang akan collapse saat scroll
          SliverAppBar(
            backgroundColor: const Color(0xFFBAAD93),
            elevation: 0,
            pinned: true, // AppBar tetap terlihat saat scroll
            expandedHeight: 360.0, // Tinggi AppBar saat expanded
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: controller.goBack,
            ),
            actions: [
              Obx(() => IconButton(
                    icon: Icon(
                      controller.isEditMode.value ? Icons.check : Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: controller.toggleEditMode,
                  )),
            ],
            flexibleSpace: FlexibleSpaceBar(
              // Hapus title dari sini agar tidak bergerak
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFBAAD93),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: _buildProfileHeader(),
              ),
            ),
          ),
          
          // Konten utama sebagai sliver
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProfileDetails(),
                const SizedBox(height: 20),
                _buildEducationDetails(),
                const SizedBox(height: 20),
                _buildParentInfo(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile header with image and basic info
  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 100, bottom: 24), // Adjust top padding for status bar
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title "Profil Saya" - sekarang di dalam background
          const Text(
            'Profil Saya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Profile image with edit option
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Profile image
              GestureDetector(
                onTap: controller.isEditMode.value ? controller.changeProfileImage : null,
                child: Obx(() => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(controller.profileImage.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
              // Edit button if in edit mode
              Obx(() => controller.isEditMode.value
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF053158),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    )
                  : const SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          
          // User name
          Obx(() => controller.isEditMode.value
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: controller.fullNameController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                )
              : Text(
                  controller.fullName.value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          const SizedBox(height: 4),
          
          // Class name
          Obx(() => Text(
                controller.className.value,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              )),
        ],
      ),
    );
  }

  // Profile details section
  Widget _buildProfileDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Informasi Pribadi', Icons.person),
            const SizedBox(height: 16),
            
            _buildProfileDetailItem('NISN', controller.nisn.value, isEditable: false),
            _buildProfileDetailItem('NIS', controller.nis.value, isEditable: false),
            
            // Phone Number - Editable
            Obx(() => _buildProfileDetailItem(
                  'Nomor Telepon',
                  controller.phoneNumber.value,
                  isEditable: true,
                  editController: controller.phoneNumberController,
                )),
            
            // Email - Editable
            Obx(() => _buildProfileDetailItem(
                  'Email',
                  controller.email.value,
                  isEditable: true,
                  editController: controller.emailController,
                )),
            
            // Gender - Not editable
            _buildProfileDetailItem('Jenis Kelamin', controller.gender.value, isEditable: false),
            
            // Birth Date - Not editable
            _buildProfileDetailItem('Tanggal Lahir', controller.birthDate.value, isEditable: false),
            
            // Address - Editable
            Obx(() => _buildProfileDetailItem(
                  'Alamat',
                  controller.address.value,
                  isEditable: true,
                  editController: controller.addressController,
                  isLongText: true,
                )),
          ],
        ),
      ),
    );
  }

  // Education details section
  Widget _buildEducationDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Informasi Pendidikan', Icons.school),
            const SizedBox(height: 16),
            
            _buildProfileDetailItem('Kelas', controller.className.value, isEditable: false),
            _buildProfileDetailItem('Tahun Masuk', controller.enrollmentYear.value, isEditable: false),
            _buildProfileDetailItem('Semester', controller.currentSemester.value, isEditable: false),
          ],
        ),
      ),
    );
  }

  // Parent information section
  Widget _buildParentInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Informasi Orang Tua', Icons.family_restroom),
            const SizedBox(height: 16),
            
            _buildProfileDetailItem('Nama Ayah', controller.fatherName.value, isEditable: false),
            _buildProfileDetailItem('Nama Ibu', controller.motherName.value, isEditable: false),
            _buildProfileDetailItem('Kontak Orang Tua', controller.parentContact.value, isEditable: false),
          ],
        ),
      ),
    );
  }

  // Helper method for section headers
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF053158).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF053158),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF053158),
          ),
        ),
      ],
    );
  }

  // Helper method for profile detail items
  Widget _buildProfileDetailItem(String label, String value, 
      {bool isEditable = false, TextEditingController? editController, bool isLongText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Obx(() => controller.isEditMode.value && isEditable
              ? TextField(
                  controller: editController,
                  maxLines: isLongText ? 3 : 1,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFBE5B50)),
                    ),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )),
        ],
      ),
    );
  }
}