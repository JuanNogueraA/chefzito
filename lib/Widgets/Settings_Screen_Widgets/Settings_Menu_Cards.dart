import 'package:flutter/material.dart';
import 'Section_Container.dart';
import 'Arrow_Item.dart';
import 'Settings_Divider.dart';

class CuentaCard extends StatelessWidget {
  const CuentaCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      icon: Icons.person_outline, iconColor: Colors.blue, title: "Cuenta",
      children: [
        ArrowItem(title: "Editar Perfil"), SettingsDivider(),
        ArrowItem(title: "Cambiar Contraseña"), SettingsDivider(),
        ArrowItem(title: "Cuenta y Datos", isLast: true),
      ],
    );
  }
}

class PreferenciasCard extends StatelessWidget {
  final VoidCallback onThemeTap;
  final VoidCallback onLanguageTap;
  final VoidCallback onUnitsTap;

  const PreferenciasCard({
    Key? key,
    required this.onThemeTap,
    required this.onLanguageTap,
    required this.onUnitsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      icon: Icons.palette_outlined, iconColor: Colors.purple, title: "Preferencias",
      children: [
        ArrowItem(title: "Tema y Apariencia", onTap: onThemeTap), SettingsDivider(),
        ArrowItem(title: "Idioma", onTap: onLanguageTap), SettingsDivider(),
        ArrowItem(title: "Unidades de Medida", onTap: onUnitsTap, isLast: true),
      ],
    );
  }
}

class AyudaCard extends StatelessWidget {
  const AyudaCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      icon: Icons.help_outline, iconColor: Colors.green, title: "Ayuda y Soporte",
      children: [
        ArrowItem(title: "Centro de Ayuda"), SettingsDivider(),
        ArrowItem(title: "Reportar un Problema"), SettingsDivider(),
        ArrowItem(title: "Contacto", isLast: true),
      ],
    );
  }
}

class InformacionCard extends StatelessWidget {
  final VoidCallback onAboutTap;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const InformacionCard({
    Key? key,
    required this.onAboutTap,
    required this.onTermsTap,
    required this.onPrivacyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      icon: Icons.info_outline, iconColor: Colors.deepOrange, title: "Información",
      children: [
        ArrowItem(title: "Acerca de Chefzito", onTap: onAboutTap), SettingsDivider(),
        ArrowItem(title: "Términos y Condiciones", onTap: onTermsTap), SettingsDivider(),
        ArrowItem(title: "Política de Privacidad", onTap: onPrivacyTap, isLast: true),
      ],
    );
  }
}