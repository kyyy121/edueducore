import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class LoginController extends GetxController {
  // Text controllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable variable to track loading state
  final RxBool isLoading = false.obs;

  // ✅ Add this: Observable variable for password visibility
  final RxBool isPasswordVisible = false.obs;

  // Login function
  void login() {
    // Set loading to true
    isLoading.value = true;

    // Create a timer for 4 seconds
    Timer(const Duration(seconds: 4), () {
      // After 4 seconds, set loading to false and navigate
      isLoading.value = false;
      Get.toNamed('/home');
    });
  }

  @override
  void onClose() {
    // Clean up controllers when the controller is disposed
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
