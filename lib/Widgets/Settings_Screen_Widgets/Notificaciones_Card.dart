import 'package:flutter/material.dart';
import 'Section_Container.dart';
import 'Switch_Item.dart';
import 'Settings_Divider.dart';

class NotificacionesCard extends StatefulWidget {
  const NotificacionesCard({Key? key}) : super(key: key);

  @override
  State<NotificacionesCard> createState() => _NotificacionesCardState();
}

class _NotificacionesCardState extends State<NotificacionesCard> {
  bool notifRecetas = true, notifLikes = true, notifComentarios = true, notifSeguidores = false, notifTendencias = true;

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      icon: Icons.notifications_none, iconColor: Colors.blue, title: "Notificaciones",
      children: [
        SwitchItem(title: "Nuevas recetas", subtitle: "Recetas de chefs que sigues", value: notifRecetas, onChanged: (val) => setState(() => notifRecetas = val)),
        const SettingsDivider(),
        SwitchItem(title: "Likes", subtitle: "Cuando alguien da like a tu receta", value: notifLikes, onChanged: (val) => setState(() => notifLikes = val)),
        const SettingsDivider(),
        SwitchItem(title: "Comentarios", subtitle: "Nuevos comentarios en tus recetas", value: notifComentarios, onChanged: (val) => setState(() => notifComentarios = val)),
        const SettingsDivider(),
        SwitchItem(title: "Nuevos seguidores", subtitle: "Cuando alguien te sigue", value: notifSeguidores, onChanged: (val) => setState(() => notifSeguidores = val)),
        const SettingsDivider(),
        SwitchItem(title: "Tendencias", subtitle: "Recetas y chefs trending", value: notifTendencias, onChanged: (val) => setState(() => notifTendencias = val), isLast: true),
      ],
    );
  }
}