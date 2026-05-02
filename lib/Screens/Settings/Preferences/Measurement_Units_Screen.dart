import 'package:flutter/material.dart';

class MeasurementUnitsScreen extends StatefulWidget {
  const MeasurementUnitsScreen({super.key});

  @override
  State<MeasurementUnitsScreen> createState() => _MeasurementUnitsScreenState();
}

class _MeasurementUnitsScreenState extends State<MeasurementUnitsScreen> {
  String _system = 'metric';
  String _temperature = 'celsius';
  String _volume = 'liters';
  String _hourFormat = '24h';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF5F1),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 14,
              left: 24,
              right: 24,
              bottom: 22,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF06A376), Color(0xFF049A8B)],
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
                      Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text('Atrás', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Icon(Icons.straighten, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Unidades de Medida',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Padding(
                  padding: EdgeInsets.only(left: 46),
                  child: Text(
                    'Personaliza como ves tus recetas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
              child: Column(
                children: [
                  _previewCard(),
                  const SizedBox(height: 10),
                  _optionGroup(
                    icon: Icons.straighten,
                    iconColor: const Color(0xFF477CFF),
                    iconBackground: const Color(0xFFE8EEFF),
                    title: 'Sistema de Medición',
                    options: [
                      _choiceTile(
                        selected: _system == 'metric',
                        color: const Color(0xFF3B82F6),
                        title: 'Métrico',
                        subtitle: 'kg, g, cm, m',
                        onTap: () => setState(() => _system = 'metric'),
                      ),
                      const SizedBox(height: 8),
                      _choiceTile(
                        selected: _system == 'imperial',
                        color: const Color(0xFF3B82F6),
                        title: 'Imperial',
                        subtitle: 'lb, oz, in, ft',
                        onTap: () => setState(() => _system = 'imperial'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _optionGroup(
                    icon: Icons.thermostat,
                    iconColor: const Color(0xFFEF4444),
                    iconBackground: const Color(0xFFFFECEC),
                    title: 'Temperatura',
                    options: [
                      _choiceTile(
                        selected: _temperature == 'celsius',
                        color: const Color(0xFFEF4444),
                        title: 'Celsius (°C)',
                        subtitle: '0°C - 100°C',
                        onTap: () => setState(() => _temperature = 'celsius'),
                      ),
                      const SizedBox(height: 8),
                      _choiceTile(
                        selected: _temperature == 'fahrenheit',
                        color: const Color(0xFFEF4444),
                        title: 'Fahrenheit (°F)',
                        subtitle: '32°F - 212°F',
                        onTap: () => setState(() => _temperature = 'fahrenheit'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _optionGroup(
                    icon: Icons.liquor,
                    iconColor: const Color(0xFFA855F7),
                    iconBackground: const Color(0xFFF5EAFE),
                    title: 'Volumen',
                    options: [
                      _choiceTile(
                        selected: _volume == 'liters',
                        color: const Color(0xFFA855F7),
                        title: 'Litros (L)',
                        subtitle: 'L, mL, cL',
                        onTap: () => setState(() => _volume = 'liters'),
                      ),
                      const SizedBox(height: 8),
                      _choiceTile(
                        selected: _volume == 'cups',
                        color: const Color(0xFFA855F7),
                        title: 'Tazas y Cucharas',
                        subtitle: 'cup, tbsp, tsp',
                        onTap: () => setState(() => _volume = 'cups'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _optionGroup(
                    icon: Icons.access_time,
                    iconColor: const Color(0xFF22C55E),
                    iconBackground: const Color(0xFFE9FBF0),
                    title: 'Formato de Hora',
                    options: [
                      _choiceTile(
                        selected: _hourFormat == '24h',
                        color: const Color(0xFF22C55E),
                        title: '24 horas',
                        subtitle: '14:30, 23:10',
                        onTap: () => setState(() => _hourFormat = '24h'),
                      ),
                      const SizedBox(height: 8),
                      _choiceTile(
                        selected: _hourFormat == '12h',
                        color: const Color(0xFF22C55E),
                        title: '12 horas',
                        subtitle: '2:30 PM, 11:00 PM',
                        onTap: () => setState(() => _hourFormat = '12h'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4D8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFF0D58F)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: Color(0xFFF59E0B), size: 17),
                            SizedBox(width: 6),
                            Text(
                              '¿Sabías qué?',
                              style: TextStyle(
                                color: Color(0xFFB45309),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Todas las recetas se convertirán automáticamente a las unidades que selecciones aquí.',
                          style: TextStyle(color: Color(0xFFB45309), fontSize: 11, height: 1.2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Preferencias guardadas')),);
                      },
                      icon: const Icon(Icons.check, color: Colors.white, size: 17),
                      label: const Text(
                        'Guardar Preferencias',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF059669),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF2D7CFF), Color(0xFF06B6D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vista Previa',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Peso', style: TextStyle(color: Colors.white70, fontSize: 10)),
              Text('500 g', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Temperatura', style: TextStyle(color: Colors.white70, fontSize: 10)),
              Text('180°C', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Volumen', style: TextStyle(color: Colors.white70, fontSize: 10)),
              Text('250 ml', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hora', style: TextStyle(color: Colors.white70, fontSize: 10)),
              Text('14:30', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _optionGroup({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required List<Widget> options,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE1E8E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: iconColor, size: 12),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF262626),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...options,
        ],
      ),
    );
  }

  Widget _choiceTile({
    required bool selected,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.08) : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? color : const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF111827),
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: selected ? color : const Color(0xFF6B7280),
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                child: const Icon(Icons.check, color: Colors.white, size: 11),
              ),
          ],
        ),
      ),
    );
  }
}
