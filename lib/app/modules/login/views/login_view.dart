import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2647),
      body: Center(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome Back Please\nEnter Email and Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  // Email Input
                  inputField(
                    hint: "Email",
                    icon: Icons.email,
                    controller: controller.emailController,
                  ),
                  const SizedBox(height: 15),

                  // Password Input with Toggle Visibility
                  inputField(
                    hint: "Password",
                    icon: Icons.lock,
                    controller: controller.passwordController,
                    isPassword: true,
                    obscure: true,
                    isVisible: controller.isPasswordVisible.value,
                    toggleVisibility: () {
                      controller.isPasswordVisible.toggle();
                    },
                  ),
                  const SizedBox(height: 25),

                  // Button Login or Loading
                  SizedBox(
                    width: 297,
                    height: 50,
                    child: controller.isLoading.value
                        ? _buildLoadingIndicator()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBE5B50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              controller.login();
                            },
                            child: const Text(
                              "Log In",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

                  const Text("Or Log in With",
                      style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 15),

                  // Social Media Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialIcon("assets/logo/icons/google.png"),
                      const SizedBox(width: 20),
                      socialIcon("assets/logo/icons/instagram.png"),
                      const SizedBox(width: 20),
                      socialIcon("assets/logo/icons/twitter.png"),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Link to Register
                  TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: const Text(
                      "Don't have an account? Register",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  // Reusable Input Field Widget
  Widget inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscure = false,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
  }) {
    return SizedBox(
      width: 297,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !isVisible : obscure,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey[700],
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
          filled: true,
          fillColor: const Color(0xFFD9D9D9),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Loading Indicator Widget
  Widget _buildLoadingIndicator() {
    return Container(
      width: 297,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFBE5B50)),
          strokeWidth: 3,
        ),
      ),
    );
  }

  // Social Icon Widget
  Widget socialIcon(String path) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(
        path,
        width: 28,
        height: 28,
        fit: BoxFit.contain,
      ),
    );
  }
}
