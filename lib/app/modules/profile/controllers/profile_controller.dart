import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // Observable variables for user profile data
  final RxString fullName = 'Zacky Achmad'.obs;
  final RxString nisn = '0012345678'.obs;
  final RxString nis = '12345'.obs;
  final RxString phoneNumber = '+62 812-3456-7890'.obs;
  final RxString email = 'zacky.achmad@student.spenma.sch.id'.obs;
  final RxString profileImage = 'assets/logo/images/profil2.png'.obs;
  final RxString className = '6-J-5'.obs;
  final RxString address = 'Jl. Pendidikan No. 123, Jakarta Selatan'.obs;
  final RxString birthDate = '15 April 2008'.obs;
  final RxString gender = 'Laki-laki'.obs;

  // Educational information
  final RxString enrollmentYear = '2021'.obs;
  final RxString currentSemester = '6'.obs;

  // Parent information
  final RxString fatherName = 'Stefen Alhadi'.obs;
  final RxString motherName = 'Aulia Syifa'.obs;
  final RxString parentContact = '+62 811-2233-4455'.obs;

  // For edit mode state
  final RxBool isEditMode = false.obs;

  // Form controllers for editing
  late TextEditingController fullNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void onInit() {
    super.onInit();
    // Initialize text controllers with current values
    fullNameController = TextEditingController(text: fullName.value);
    phoneNumberController = TextEditingController(text: phoneNumber.value);
    emailController = TextEditingController(text: email.value);
    addressController = TextEditingController(text: address.value);
    
    // Load user profile data
    _loadProfileData();
  }

  @override
  void onClose() {
    // Dispose of controllers when the controller is closed
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }

  // Function to load profile data (would connect to your data service in a real app)
  void _loadProfileData() {
    // In a real application, you would fetch this data from a service or local storage
    // For now, we're using hardcoded values initialized above
  }

  // Toggle edit mode
  void toggleEditMode() {
    if (isEditMode.value) {
      // Save changes
      saveChanges();
    }
    isEditMode.toggle();
  }

  // Save profile changes
  void saveChanges() {
    fullName.value = fullNameController.text;
    phoneNumber.value = phoneNumberController.text;
    email.value = emailController.text;
    address.value = addressController.text;
    
    // In a real app, you would send these changes to your backend or storage service
    Get.snackbar(
      'Sukses',
      'Profil berhasil diperbarui',
      backgroundColor: const Color(0xFF053158),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
    );
  }

  // Change profile image
  void changeProfileImage() {
    // In a real app, you would implement image picking functionality
    // For demo, we'll just show a message
    Get.snackbar(
      'Ganti Foto Profil',
      'Fitur ini akan memungkinkan pengguna untuk mengubah foto profil',
      backgroundColor: const Color(0xFF053158),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
    );
  }

  // Navigate back function
  void goBack() {
    Get.back();
  }
}