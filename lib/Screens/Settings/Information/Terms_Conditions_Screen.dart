import 'package:flutter/material.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/Widgets/Legal_Screen_Widgets/gradient_welcome_card.dart';
import 'package:chefzito/Widgets/Legal_Screen_Widgets/terms_section_card.dart';
import 'package:chefzito/Widgets/Legal_Screen_Widgets/warning_card.dart';
import 'package:chefzito/Widgets/Legal_Screen_Widgets/acceptance_status_card.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
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
                colors: [Color(0xFF7C3AED), Color(0xFF9333EA)],
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
                    Icon(Icons.description_outlined, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Términos y\nCondiciones',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
              children: const [
                GradientWelcomeCard(),
                TermsSectionCard(
                  title: '1. Aceptación de Términos',
                  description:
                      'Al descargar, instalar o utilizar Chefzito, aceptas estar legalmente sujeto a estos términos. Si no estás de acuerdo, debes dejar de usar la aplicación inmediatamente.',
                ),
                TermsSectionCard(
                  title: '2. Uso de la Plataforma',
                  description:
                      'Chefzito está diseñado para sugerir recetas con base en tus ingredientes. El contenido es orientativo y no reemplaza recomendaciones profesionales de salud o nutrición.',
                ),
                TermsSectionCard(
                  title: '3. Cuentas de Usuario',
                  description:
                      'Eres responsable de mantener la confidencialidad de tus credenciales y de todas las actividades realizadas en tu cuenta. Notifica de inmediato cualquier uso no autorizado.',
                ),
                TermsSectionCard(
                  title: '4. Publicación de Contenido',
                  description:
                      'Puedes compartir recetas, fotos y comentarios. Al hacerlo, garantizas que posees los derechos del contenido y otorgas a Chefzito una licencia de uso para mostrarlo dentro de la app.',
                ),
                TermsSectionCard(
                  title: '5. Privacidad y Datos',
                  description:
                      'Tu uso de la aplicación también se rige por nuestra Política de Privacidad. Nos comprometemos a tratar tus datos de forma responsable y segura.',
                ),
                TermsSectionCard(
                  title: '6. Propiedad Intelectual',
                  description:
                      'La marca Chefzito, su diseño, código y elementos visuales son propiedad de sus titulares. No está permitido copiar, distribuir o modificar sin autorización previa.',
                ),
                TermsSectionCard(
                  title: '7. Modificaciones del Servicio',
                  description:
                      'Chefzito puede actualizar funciones, precios o disponibilidad en cualquier momento para mejorar la experiencia del usuario.',
                ),
                TermsSectionCard(
                  title: '8. Limitación de Responsabilidad',
                  description:
                      'No garantizamos que el servicio esté libre de interrupciones o errores en todo momento. Chefzito no será responsable por daños indirectos derivados del uso de la aplicación.',
                ),
                TermsSectionCard(
                  title: '9. Ley Aplicable',
                  description:
                      'Estos términos se interpretan conforme a la legislación aplicable en tu jurisdicción. Cualquier disputa será resuelta por tribunales competentes.',
                ),
                WarningCard(),
                AcceptanceStatusCard(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
