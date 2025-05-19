import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Controller untuk animasi
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Konfigurasi controller animasi
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Animasi slide dari kiri
    _slideAnimation = Tween<double>(begin: -1.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    // Animasi skala yang membuat logo membesar setelah slide
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Animasi rotasi ringan untuk logo
    _rotateAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController, 
        curve: Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    // Animasi untuk mengatur transparansi
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.5, curve: Curves.easeIn),
      ),
    );

    // Mulai animasi
    _animationController.forward();

    // Timer untuk navigasi ke halaman login
    Timer(const Duration(milliseconds: 3800), () {
      // Efek menghilang sebelum navigasi
      _animationController.reverse().then((value) {
        Get.offAllNamed(Routes.LOGIN);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFBE5B50),
      body: Container(
        // Menambahkan gradient untuk latar belakang yang lebih menarik
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFBE5B50),
              const Color(0xFFBE5B50).withOpacity(0.8),
              const Color(0xFFD17A70),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Elemen dekoratif latar belakang (lingkaran)
            Positioned(
              top: -screenHeight * 0.1,
              left: -screenWidth * 0.2,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value * 0.3,
                    child: Container(
                      width: screenWidth * 0.7,
                      height: screenWidth * 0.7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Garis estetik diagonal 1
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.2,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final double opacity = _animationController.value * 0.15;
                  return Opacity(
                    opacity: opacity,
                    child: Container(
                      height: 1,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white70, Colors.transparent],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Garis estetik diagonal 2
            Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.7,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final double opacity = _animationController.value * 0.15;
                  return Opacity(
                    opacity: opacity,
                    child: Container(
                      height: 1,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.white70, Colors.transparent],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Elemen dekoratif tambahan
            Positioned(
              bottom: -screenHeight * 0.15,
              right: -screenWidth * 0.15,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value * 0.3,
                    child: Container(
                      width: screenWidth * 0.6,
                      height: screenWidth * 0.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Logo utama dengan animasi dari samping kiri
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_slideAnimation.value * screenWidth, 0),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: Opacity(
                          opacity: _opacityAnimation.value,
                          child: SizedBox(
                            width: screenWidth * 0.5,
                            height: screenWidth * 0.5,
                            child: Image.asset("assets/logo/logo-splash.png"),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Text dengan animasi fade-in
            Positioned(
              bottom: screenHeight * 0.15,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value,
                    child: Center(
                      child: Text(
                        "SMPN 5 Malang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Text versi aplikasi
            Positioned(
              bottom: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _opacityAnimation.value * 0.7,
                    child: Center(
                      child: Text(
                        "v 1.0.0",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}