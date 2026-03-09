import 'package:flutter/material.dart';
import 'dart:math' as math;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _floatAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF8C42), Color(0xFFFF6B6B), Color(0xFFFF4757)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decoraciones de verduras flotantes por toda la pantalla
              _buildFloatingVegetables(),
              // Contenido principal
              SingleChildScrollView(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          // Robot Chef con animación flotante
                          _buildFloatingRobot(),
                          const SizedBox(height: 24),
                          // Título principal
                          _buildTitle(),
                          const SizedBox(height: 6),
                          // Subtítulo
                          _buildSubtitle(),
                          const SizedBox(height: 50),
                          // Tarjeta 1: Busca por ingredientes
                          _buildFeatureCard(
                            icon: Icons.restaurant_menu_rounded,
                            title: 'Busca por ingredientes',
                            subtitle: 'Cocina con lo que tienes',
                            delay: 200,
                          ),
                          const SizedBox(height: 20),
                          // Tarjeta 2: Comunidad activa
                          _buildFeatureCard(
                            icon: Icons.groups_rounded,
                            title: 'Comunidad activa',
                            subtitle: 'Comparte tus creaciones',
                            delay: 400,
                          ),
                          const SizedBox(height: 20),
                          // Tarjeta 3: Rankings y tendencias
                          _buildFeatureCard(
                            icon: Icons.trending_up_rounded,
                            title: 'Rankings y tendencias',
                            subtitle: 'Descubre lo más popular',
                            delay: 600,
                          ),
                          const SizedBox(height: 45),
                          // Botón principal
                          _buildMainButton(context),
                          const SizedBox(height: 24),
                          // Texto final
                          _buildBottomText(),
                          const SizedBox(height: 30),
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
    );
  }

  Widget _buildFloatingRobot() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, math.sin(_floatAnimation.value * math.pi) * 8),
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Image.asset(
              'assets/img/Chefcito_CompletoGorroBlanco.png',
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingVegetables() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Tomate - Izquierda superior
            Positioned(
              left: 10,
              top: 80 + math.sin(_floatAnimation.value * math.pi) * 5,
              child: Transform.rotate(
                angle: -0.1 + math.sin(_floatAnimation.value * math.pi) * 0.05,
                child: const Text('🍅', style: TextStyle(fontSize: 60)),
              ),
            ),
            // Zanahoria - Derecha superior
            Positioned(
              right: 15,
              top: 100 + math.cos(_floatAnimation.value * math.pi) * 6,
              child: Transform.rotate(
                angle: 0.2 + math.cos(_floatAnimation.value * math.pi) * 0.05,
                child: const Text('🥕', style: TextStyle(fontSize: 55)),
              ),
            ),
            // Cebolla - Izquierda inferior
            Positioned(
              left: 30,
              bottom: 180 + math.sin(_floatAnimation.value * math.pi + 1) * 7,
              child: Transform.rotate(
                angle: -0.3 + math.sin(_floatAnimation.value * math.pi) * 0.04,
                child: const Text('🧅', style: TextStyle(fontSize: 50)),
              ),
            ),
            // Lechuga - Derecha inferior
            Positioned(
              right: 20,
              bottom: 160 + math.cos(_floatAnimation.value * math.pi + 2) * 8,
              child: Transform.rotate(
                angle: 0.25 + math.cos(_floatAnimation.value * math.pi) * 0.04,
                child: const Text('🥬', style: TextStyle(fontSize: 65)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Chefcito',
      style: TextStyle(
        fontSize: 56,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
        shadows: [
          Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'Tu chef personal de bolsillo',
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int delay,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 600 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.85 + (value * 0.15),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.28),
              Colors.white.withOpacity(0.18),
            ],
          ),
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: Colors.white.withOpacity(0.35), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.35),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.white.withOpacity(0.92),
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainButton(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Navegar a la pantalla de login
            Navigator.pushNamed(context, '/login');
          },
          borderRadius: BorderRadius.circular(32),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFF4757),
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  '¡Empezar a cocinar!',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFF4757),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomText() {
    return Text(
      'Ahorra tiempo, reduce desperdicios, ¡cocina mejor!',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white.withOpacity(0.9),
        fontWeight: FontWeight.w400,
        height: 1.3,
      ),
    );
  }
}
