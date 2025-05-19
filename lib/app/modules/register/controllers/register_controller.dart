import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final nisnController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ✅ Tambahan untuk visibilitas password
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  void register() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 4)); // Simulasi loading

    isLoading.value = false;
    Get.offAllNamed(Routes.LOGIN); // Navigasi ke halaman login
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    nisnController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
