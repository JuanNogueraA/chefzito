import 'package:flutter/material.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/Widgets/Legal_Screen_Widgets/terms_section_card.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F46E5), Color(0xFF8B5CF6)],
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
                      Icon(Icons.arrow_back, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text('Atrás', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Icon(Icons.shield_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Política de Privacidad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tu información, tu control',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Compromiso de Privacidad',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'En Chefzito protegemos tus datos personales con medidas técnicas y organizativas adecuadas. Nunca vendemos tu información a terceros.',
                        style: TextStyle(color: Colors.white, fontSize: 13, height: 1.35),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const TermsSectionCard(
                  title: '1. Información que Recopilamos',
                  description:
                      'Podemos recopilar datos como nombre, correo, preferencias culinarias, ingredientes frecuentes y actividad dentro de la app para personalizar tu experiencia.',
                ),
                const TermsSectionCard(
                  title: '2. Cómo Usamos tu Información',
                  description:
                      'Usamos tus datos para recomendar recetas, mejorar funciones, ofrecer soporte y mantener la seguridad de la plataforma.',
                ),
                const TermsSectionCard(
                  title: '3. Compartición de Información',
                  description:
                      'Solo compartimos información cuando es necesario para operar el servicio (por ejemplo, proveedores tecnológicos) o por obligación legal.',
                ),
                const TermsSectionCard(
                  title: '4. Cookies y Tecnologías Similares',
                  description:
                      'Utilizamos cookies y almacenamiento local para recordar tus preferencias y analizar uso de la aplicación de manera agregada.',
                ),
                const TermsSectionCard(
                  title: '5. Seguridad de la Información',
                  description:
                      'Aplicamos medidas de cifrado, controles de acceso y monitoreo para proteger tus datos frente a accesos no autorizados.',
                ),
                const TermsSectionCard(
                  title: '6. Transferencias Internacionales',
                  description:
                      'Si procesamos datos fuera de tu país, garantizamos mecanismos adecuados para mantener un nivel de protección equivalente.',
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tus Derechos',
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      _BulletLine('Acceder a tus datos personales'),
                      _BulletLine('Rectificar o actualizar información'),
                      _BulletLine('Solicitar eliminación de tu cuenta'),
                      _BulletLine('Limitar el procesamiento de datos'),
                      _BulletLine('Portabilidad de tu información'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFBBF7D0)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified_user_outlined, color: Color(0xFF16A34A)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Tu privacidad es nuestra prioridad: actualizamos esta política periódicamente para mantenerte protegido.',
                          style: TextStyle(color: Color(0xFF166534), fontSize: 12, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _settingsPanel(
                  title: 'Gestionar tu Privacidad',
                  rows: const [
                    _SettingRow(label: 'Cuenta en modo privado', value: 'Activado'),
                    _SettingRow(label: 'Compartir datos de analítica', value: 'Desactivado'),
                    _SettingRow(label: 'Permitir notificaciones', value: 'Activado'),
                  ],
                ),
                const SizedBox(height: 8),
                _settingsPanel(
                  title: 'Contacto',
                  rows: const [
                    _SettingRow(label: 'Correo de privacidad', value: 'privacy@chefzito.com'),
                    _SettingRow(label: 'Soporte', value: 'support@chefzito.com'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }

  Widget _settingsPanel({required String title, required List<Widget> rows}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          ...rows,
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;

  const _BulletLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3),
            child: Icon(Icons.circle, size: 7, color: Color(0xFF475569)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Color(0xFF475569), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final String value;

  const _SettingRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
