import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const headerGreenA = Color(0xFF09C366);
    const headerGreenB = Color(0xFF00BF49);

    final categories = const [
      _HelpCategory(
        icon: Icons.menu_book_outlined,
        title: 'Primeros pasos',
        subtitle: 'Aprende a\nusar Celtoouille',
        articles: '12 articulos',
        iconColor: Color(0xFF2563EB),
        iconBg: Color(0xFFDCE8FA),
      ),
      _HelpCategory(
        icon: Icons.search,
        title: 'Buscar recetas',
        subtitle: 'Encuentra el\nplato perfecto',
        articles: '8 articulos',
        iconColor: Color(0xFF0AAA4C),
        iconBg: Color(0xFFDDF4E5),
      ),
      _HelpCategory(
        icon: Icons.videocam_outlined,
        title: 'Crear recetas',
        subtitle: 'Comparte\ntus\ncreaciones',
        articles: '15 articulos',
        iconColor: Color(0xFF9333EA),
        iconBg: Color(0xFFEADDF8),
      ),
      _HelpCategory(
        icon: Icons.chat_bubble_outline,
        title: 'Comunidad',
        subtitle: 'Interactua con\notros chefs',
        articles: '10 articulos',
        iconColor: Color(0xFFFF5A00),
        iconBg: Color(0xFFFCEBDB),
      ),
    ];

    final faqs = const [
      _FaqItem(
        question: 'Como busco recetas con\nmis ingredientes?',
        answer: 'Ve a la seccion Buscar y anade\nlos ingredientes que tienes.',
      ),
      _FaqItem(
        question: 'Puedo guardar recetas\npara despues?',
        answer: 'Si, toca el icono de guardado en\ncualquier receta.',
      ),
      _FaqItem(
        question: 'Como publico mi\npropia receta?',
        answer: 'Usa el boton + en la pantalla de\ninicio o ve a Crear Receta.',
      ),
      _FaqItem(
        question: 'Como sigo a otros chefs?',
        answer: 'Visita su perfil y toca el boton Seguir.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFD7E8E2),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 24,
              right: 24,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [headerGreenA, headerGreenB],
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
                      SizedBox(width: 10),
                      Text(
                        'Atras',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27 / 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Centro de Ayuda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 49 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'En que podemos ayudarte?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35 / 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar en ayuda...',
                      hintStyle: TextStyle(color: Color(0xBFFFFFFF)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
              children: [
                const Text(
                  'Categorias',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 39 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    mainAxisExtent: 260,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) =>
                      _CategoryCard(item: categories[index]),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Preguntas Frecuentes',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 39 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                ...faqs.map(
                  (faq) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _FaqCard(item: faq),
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC8D8ED), Color(0xFFB6E5EE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFA8CCDA)),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: Color(0xFF2563EB),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No encuentras lo que buscas?',
                        style: TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 43 / 1.6,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Nuestro equipo esta listo para ayudarte',
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 31 / 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3478E5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Contactar Soporte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final _HelpCategory item;

  const _CategoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8DCE2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 28),
          ),
          const SizedBox(height: 14),
          Text(
            item.title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.28,
            ),
          ),
          const Spacer(),
          Text(
            item.subtitle,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 1.30,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.articles,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqCard extends StatelessWidget {
  final _FaqItem item;

  const _FaqCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7F9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8DCE2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.question,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.32,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.answer,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 18,
                    height: 1.32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

class _HelpCategory {
  final IconData icon;
  final String title;
  final String subtitle;
  final String articles;
  final Color iconColor;
  final Color iconBg;

  const _HelpCategory({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.articles,
    required this.iconColor,
    required this.iconBg,
  });
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});
}
