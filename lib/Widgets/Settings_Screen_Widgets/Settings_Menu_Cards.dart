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
  const PreferenciasCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      icon: Icons.palette_outlined, iconColor: Colors.purple, title: "Preferencias",
      children: [
        ArrowItem(title: "Tema y Apariencia"), SettingsDivider(),
        ArrowItem(title: "Idioma"), SettingsDivider(),
        ArrowItem(title: "Unidades de Medida", isLast: true),
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
  const InformacionCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const SectionContainer(
      icon: Icons.info_outline, iconColor: Colors.deepOrange, title: "Información",
      children: [
        ArrowItem(title: "Acerca de Chefzito"), SettingsDivider(),
        ArrowItem(title: "Términos y Condiciones"), SettingsDivider(),
        ArrowItem(title: "Política de Privacidad", isLast: true),
      ],
    );
  }
}