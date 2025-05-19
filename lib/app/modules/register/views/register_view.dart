import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../../../routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome Please\nSign Up In Here",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 30),

                  inputField("Name", Icons.person, controller.nameController),
                  inputField("Email", Icons.email, controller.emailController),
                  inputField("NISN", Icons.confirmation_number, controller.nisnController),

                  // Password Field with Visibility Toggle
                  passwordField(
                    hint: "Create Password",
                    controller: controller.passwordController,
                    isVisible: controller.isPasswordVisible.value,
                    toggle: () => controller.isPasswordVisible.toggle(),
                  ),

                  // Confirm Password Field with Visibility Toggle
                  passwordField(
                    hint: "Re-type Password",
                    controller: controller.confirmPasswordController,
                    isVisible: controller.isConfirmPasswordVisible.value,
                    toggle: () => controller.isConfirmPasswordVisible.toggle(),
                  ),

                  const SizedBox(height: 20),

                  // Button with Loading
                  controller.isLoading.value
                      ? Container(
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
                        )
                      : SizedBox(
                          width: 297,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFBE5B50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () => controller.register(),
                            child: const Text("Daftar", style: TextStyle(color: Colors.black, fontSize: 16)),
                          ),
                        ),

                  const SizedBox(height: 30),
                  const Text("Or Sign Up With", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 15),

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

                  TextButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    child: const Text.rich(
                      TextSpan(
                        text: "Do You Have Account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text: "Log In", style: TextStyle(color: Colors.lightBlueAccent)),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget inputField(String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: 297,
        height: 50,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Password field with toggle visibility
  Widget passwordField({
    required String hint,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: 297,
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey[700]),
              onPressed: toggle,
            ),
            filled: true,
            fillColor: const Color(0xFFD9D9D9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget socialIcon(String path) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(path, width: 28, height: 28, fit: BoxFit.contain),
    );
  }
}
