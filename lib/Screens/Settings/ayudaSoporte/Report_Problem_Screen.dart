import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chefzito/Widgets/NavBar.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});

  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(
    text: 'chef@celtouille.com',
  );

  final ImagePicker _imagePicker = ImagePicker();
  String? _pickedImageName;

  String _selectedType = 'bug';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickScreenshot() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1600,
    );

    if (!mounted || image == null) {
      return;
    }

    setState(() {
      _pickedImageName = image.name;
    });
  }

  void _submitReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte enviado. Gracias por tu ayuda.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFED),
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
                colors: [Color(0xFFFF2A55), Color(0xFFFF6A00)],
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
                        Icons.warning_amber_rounded,
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
                            'Reportar un Problema',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40 / 1.6,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Ayudanos a mejorar la app',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29 / 1.6,
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
                  'Que tipo de problema tienes?',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 39 / 1.6,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.83,
                  children: [
                    _TypeCard(
                      icon: Icons.bug_report_outlined,
                      title: 'Error/Bug',
                      subtitle: 'La app no funciona\ncorrectamente',
                      iconColor: const Color(0xFFDC2626),
                      iconBg: const Color(0xFFF8DDDF),
                      selected: _selectedType == 'bug',
                      onTap: () => setState(() => _selectedType = 'bug'),
                    ),
                    _TypeCard(
                      icon: Icons.phone_android_outlined,
                      title: 'Cierre inesperado',
                      subtitle: 'La app se cierra sola',
                      iconColor: const Color(0xFFEA580C),
                      iconBg: const Color(0xFFFBE9D9),
                      selected: _selectedType == 'crash',
                      onTap: () => setState(() => _selectedType = 'crash'),
                    ),
                    _TypeCard(
                      icon: Icons.bolt_outlined,
                      title: 'Rendimiento',
                      subtitle: 'La app va lenta',
                      iconColor: const Color(0xFFCA8A04),
                      iconBg: const Color(0xFFF6F0C7),
                      selected: _selectedType == 'performance',
                      onTap: () =>
                          setState(() => _selectedType = 'performance'),
                    ),
                    _TypeCard(
                      icon: Icons.photo_outlined,
                      title: 'Problema\nde contenido',
                      subtitle: 'inapropiado o\nerroneo',
                      iconColor: const Color(0xFF9333EA),
                      iconBg: const Color(0xFFEBDCFA),
                      selected: _selectedType == 'content',
                      onTap: () => setState(() => _selectedType = 'content'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _FormCard(
                  title: 'Titulo del problema',
                  child: TextField(
                    controller: _titleController,
                    decoration: _inputDecoration(
                      hintText: 'Ej: La app se cierra al buscar recetas',
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _FormCard(
                  title: 'Describe el problema',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: _inputDecoration(
                          hintText:
                              'Proporciona todos los detalles posibles: que paso y como repetirlo.',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Cuantos mas detalles proporciones, mas rapido podremos solucionarlo',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _FormCard(
                  title: 'Capturas de pantalla (opcional)',
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: _pickScreenshot,
                          icon: const Icon(
                            Icons.upload,
                            color: Color(0xFF111827),
                            size: 19,
                          ),
                          label: const Text(
                            'Agregar captura',
                            style: TextStyle(
                              color: Color(0xFF111827),
                              fontWeight: FontWeight.w500,
                              fontSize: 22 / 1.6,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFD3D7DE)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      if (_pickedImageName != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _pickedImageName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _FormCard(
                  title: 'Email de contacto',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          hintText: 'tuemail@dominio.com',
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Te contactaremos si necesitamos mas informacion',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _submitReport,
                    icon: const Icon(
                      Icons.send_outlined,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'Enviar Reporte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 29 / 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style:
                        ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.zero,
                        ).copyWith(
                          backgroundColor: WidgetStateProperty.resolveWith(
                            (_) => null,
                          ),
                        ),
                  ),
                ),
                const SizedBox(height: 4),
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

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color iconBg;
  final bool selected;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.iconBg,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? const Color(0xFFFB923C) : const Color(0xFFE5E7EB),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 19,
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 16,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _FormCard({required this.title, required this.child});

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
