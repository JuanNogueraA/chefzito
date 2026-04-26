import 'package:flutter/material.dart';

import 'package:chefzito/Widgets/NavBar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mensaje enviado correctamente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EFF5),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 24,
              right: 24,
              bottom: 22,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF11B5D9), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  blurRadius: 10,
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
                      Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      SizedBox(width: 10),
                      Text(
                        'Atras',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contacto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 42 / 1.6,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Estamos aqui para ayudarte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30 / 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              children: [
                const Text(
                  'Formas de contacto',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 42 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 175,
                  children: const [
                    _ContactMethodCard(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: 'hola@celtouille.com',
                      iconColor: Color(0xFF2563EB),
                      iconBg: Color(0xFFDCE8FA),
                    ),
                    _ContactMethodCard(
                      icon: Icons.phone_outlined,
                      title: 'Telefono',
                      value: '+34 900 123 456',
                      iconColor: Color(0xFF16A34A),
                      iconBg: Color(0xFFDDF4E5),
                    ),
                    _ContactMethodCard(
                      icon: Icons.location_on_outlined,
                      title: 'Direccion',
                      value: 'Madrid, Espana',
                      iconColor: Color(0xFFEF4444),
                      iconBg: Color(0xFFFCE4E5),
                    ),
                    _ContactMethodCard(
                      icon: Icons.public,
                      title: 'Web',
                      value: 'www.celtouille.com',
                      iconColor: Color(0xFF9333EA),
                      iconBg: Color(0xFFEADDF8),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Siguenos en redes',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 42 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                const _SocialCard(
                  icon: Icons.flutter_dash,
                  iconBg: Color(0xFF1D9CE2),
                  title: 'Twitter',
                  handle: '@celtouille',
                ),
                const SizedBox(height: 10),
                const _SocialCard(
                  icon: Icons.camera_alt_outlined,
                  iconBg: Color(0xFFEC4899),
                  title: 'Instagram',
                  handle: '@celtouille',
                ),
                const SizedBox(height: 10),
                const _SocialCard(
                  icon: Icons.facebook,
                  iconBg: Color(0xFF2563EB),
                  title: 'Facebook',
                  handle: 'celtouille',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Envianos un mensaje',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 42 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                _FieldCard(
                  title: 'Nombre',
                  child: TextField(
                    controller: _nameController,
                    decoration: _inputDecoration(hintText: 'Tu nombre'),
                  ),
                ),
                const SizedBox(height: 10),
                _FieldCard(
                  title: 'Email',
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _inputDecoration(hintText: 'tu@email.com'),
                  ),
                ),
                const SizedBox(height: 10),
                _FieldCard(
                  title: 'Asunto',
                  child: TextField(
                    controller: _subjectController,
                    decoration: _inputDecoration(hintText: 'De que se trata?'),
                  ),
                ),
                const SizedBox(height: 10),
                _FieldCard(
                  title: 'Mensaje',
                  child: TextField(
                    controller: _messageController,
                    maxLines: 5,
                    decoration: _inputDecoration(
                      hintText: 'Cuentanos como podemos ayudarte...',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 52,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF11B5D9), Color(0xFF3B82F6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.12),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Enviar Mensaje',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5EBC6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE8DCAA)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horario de atencion',
                        style: TextStyle(
                          color: Color(0xFF374151),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Lunes a Viernes: 9:00 - 18:00\nSabados: 10:00 - 14:00\nDomingos: Cerrado',
                        style: TextStyle(
                          color: Color(0xFF4B5563),
                          fontSize: 16,
                          height: 1.55,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Respondemos en menos de 24 horas',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
      bottomNavigationBar: const Navbar(),
    );
  }

  InputDecoration _inputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 15),
      filled: true,
      fillColor: const Color(0xFFF1F3F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}

class _ContactMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;
  final Color iconBg;

  const _ContactMethodCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String handle;

  const _SocialCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.handle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  handle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 27),
        ],
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _FieldCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD1D5DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
