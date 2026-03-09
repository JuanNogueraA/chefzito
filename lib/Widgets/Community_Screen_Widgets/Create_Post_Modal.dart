import 'package:flutter/material.dart';
import 'Privacy_Option.dart'; // Importamos el widget que acabamos de crear

void showCreatePostModal({
  required BuildContext context,
  required bool isPublicTab,
  required Color primaryColor,
  required Color secondaryColor,
  required ValueChanged<bool> onTabChanged, // Para actualizar la pantalla de fondo
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [primaryColor, secondaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Crear Publicación", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Privacidad de la publicación", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            PrivacyOption(
                              icon: Icons.public, title: "Público", subtitle: "Todos pueden ver", 
                              isActive: isPublicTab, color: const Color(0xFFFF5E00),
                              onTap: () {
                                setModalState(() => isPublicTab = true);
                                onTabChanged(true); // Actualiza la pantalla principal
                              },
                            ),
                            const SizedBox(width: 15),
                            PrivacyOption(
                              icon: Icons.people_alt_outlined, title: "Solo Amigos", subtitle: "Solo tus amigos", 
                              isActive: !isPublicTab, color: const Color(0xFF8A2BE2),
                              onTap: () {
                                setModalState(() => isPublicTab = false);
                                onTabChanged(false); // Actualiza la pantalla principal
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text("Foto de tu platillo", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!, width: 2), borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey[400]),
                              const SizedBox(height: 10),
                              Text("Toca para subir foto", style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
                              Text("JPG, PNG hasta 10MB", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text("Nombre de la receta", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 10),
                        TextField(decoration: InputDecoration(hintText: "Ej: Pasta Carbonara", filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                        const SizedBox(height: 25),
                        const Text("Descripción", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                        const SizedBox(height: 10),
                        TextField(maxLines: 3, decoration: InputDecoration(hintText: "Cuéntanos sobre tu platillo...", filled: true, fillColor: Colors.grey[100], border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                        const SizedBox(height: 30),
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(gradient: LinearGradient(colors: [primaryColor.withOpacity(0.6), secondaryColor.withOpacity(0.6)]), borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle_outline, color: Colors.white), const SizedBox(width: 10),
                              Text(isPublicTab ? "Publicar Públicamente" : "Publicar para Amigos", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      );
    },
  );
}