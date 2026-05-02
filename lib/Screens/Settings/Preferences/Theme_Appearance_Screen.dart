import 'package:flutter/material.dart';

class ThemeAppearanceScreen extends StatefulWidget {
  const ThemeAppearanceScreen({super.key});

  @override
  State<ThemeAppearanceScreen> createState() => _ThemeAppearanceScreenState();
}

class _ThemeAppearanceScreenState extends State<ThemeAppearanceScreen> {
  int _selectedTheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2EEF5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 14,
              left: 24,
              right: 24,
              bottom: 26,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8A4DFF), Color(0xFFFF2F95)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  blurRadius: 12,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text('Atrás', style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Tema y Apariencia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Personaliza el look de Chefzito',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tema',
                    style: TextStyle(
                      color: Color(0xFF273042),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _themeOption(
                    index: 0,
                    title: 'Claro',
                    subtitle: 'Perfecto para cocinar de día',
                    gradient: const [Color(0xFFFF8A00), Color(0xFFFF5DA8)],
                    icon: Icons.wb_sunny_outlined,
                  ),
                  const SizedBox(height: 16),
                  _themeOption(
                    index: 1,
                    title: 'Oscuro',
                    subtitle: 'Ideal para la noche',
                    gradient: const [Color(0xFF0F172A), Color(0xFF1E293B)],
                    icon: Icons.nightlight_round,
                  ),
                  const SizedBox(height: 16),
                  _themeOption(
                    index: 2,
                    title: 'Automático',
                    subtitle: 'Se adapta a tu sistema',
                    gradient: const [Color(0xFFA855F7), Color(0xFF3B82F6)],
                    icon: Icons.palette_outlined,
                  ),
                  const SizedBox(height: 26),
                  const Text(
                    'Vista previa',
                    style: TextStyle(
                      color: Color(0xFF273042),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8A00), Color(0xFFE94EA1)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFF6F00),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.55),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 8,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 86,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeOption({
    required int index,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required IconData icon,
  }) {
    final selected = _selectedTheme == index;

    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => setState(() => _selectedTheme = index),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFD8D8DE)),
        ),
        child: Row(
          children: [
            Container(
              width: 66,
              height: 66,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 34),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF253044),
                      fontSize: 33,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF627084),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? const Color(0xFFA855F7) : const Color(0xFFE7E8ED),
              ),
              child: Icon(
                Icons.check,
                size: 24,
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
