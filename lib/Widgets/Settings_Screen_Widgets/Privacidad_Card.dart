import 'package:flutter/material.dart';
import 'Section_Container.dart';
import 'Switch_Item.dart';
import 'Settings_Divider.dart';

class PrivacidadCard extends StatefulWidget {
  const PrivacidadCard({Key? key}) : super(key: key);

  @override
  State<PrivacidadCard> createState() => _PrivacidadCardState();
}

class _PrivacidadCardState extends State<PrivacidadCard> {
  bool privPublico = true, privEmail = false, privRecetas = true;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      icon: Icons.shield_outlined, iconColor: Colors.purpleAccent, title: "Privacidad",
      children: [
        SwitchItem(title: "Perfil público", subtitle: "Cualquiera puede ver tu perfil", value: privPublico, onChanged: (val) => setState(() => privPublico = val)),
        const SettingsDivider(),
        SwitchItem(title: "Mostrar email", subtitle: "Visible en tu perfil", value: privEmail, onChanged: (val) => setState(() => privEmail = val)),
        const SettingsDivider(),
        SwitchItem(title: "Recetas públicas", subtitle: "Todos pueden ver tus recetas", value: privRecetas, onChanged: (val) => setState(() => privRecetas = val), isLast: true),
      ],
    );
  }
}