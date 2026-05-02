import 'package:flutter/material.dart';
import 'package:chefzito/Widgets/NavBar.dart';

class AboutChefzitoScreen extends StatelessWidget {
  const AboutChefzitoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 18,
              right: 18,
              bottom: 22,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF7A00), Color(0xFFFF2D55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('Atrás', style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 78,
                    height: 78,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('👨‍🍳', style: TextStyle(fontSize: 34)),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.14),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Chefzito',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tu chef personal de bolsillo',
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Versión 1.0.0',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
              children: [
                _sectionCard(
                  title: 'Nuestra Misión',
                  content:
                      'En Chefzito creemos que cocinar debe ser accesible, divertido y sostenible. Nuestra misión es ayudarte a aprovechar al máximo los ingredientes que tienes en casa, reducir el desperdicio y conectar con una comunidad de cocineros apasionados.\n\nCon tecnología inteligente y el poder de la comunidad, transformamos la pregunta "¿qué cocinar?" en una experiencia emocionante llena de posibilidades.',
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Chefzito en Números',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _StatItem(icon: Icons.people_outline, value: '50K+', label: 'Usuarios activos')),
                          SizedBox(width: 12),
                          Expanded(child: _StatItem(icon: Icons.favorite_border, value: '15K+', label: 'Recetas compartidas')),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _StatItem(icon: Icons.local_dining_outlined, value: '2K+', label: 'Ingredientes')),
                          SizedBox(width: 12),
                          Expanded(child: _StatItem(icon: Icons.public, value: '25+', label: 'Países')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                _sectionCard(
                  title: 'El Equipo',
                  content:
                      'Chefzito es creado por un equipo apasionado de desarrolladores, diseñadores y chefs que creen en el poder de la tecnología para hacer la cocina más accesible y divertida para todos.',
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        'Contáctanos',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '¿Tienes preguntas, sugerencias o colaboración?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 12),
                      _ContactRow(icon: Icons.email_outlined, text: 'hola@chefzito.com'),
                      SizedBox(height: 6),
                      _ContactRow(icon: Icons.public, text: 'www.chefzito.com'),
                      SizedBox(height: 6),
                      _ContactRow(icon: Icons.camera_alt_outlined, text: '@chefzitoapp'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'Hecho con amor y mucho fuego',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ),
                const SizedBox(height: 4),
                const Center(
                  child: Text(
                    '© 2026 Chefzito. Todos los derechos reservados.',
                    style: TextStyle(color: Color(0xFFB6BDC7), fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }

  Widget _sectionCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF60A5FA), size: 15),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4B5563),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
