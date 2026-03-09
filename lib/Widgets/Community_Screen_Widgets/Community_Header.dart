import 'package:flutter/material.dart';
// Importa la pantalla de búsqueda, ajusta la ruta si es necesario
import '../../Screens/Community_Search_Screen.dart'; 

class CommunityHeader extends StatelessWidget {
  final bool isPublicTab;
  final Color primaryColor;
  final Color secondaryColor;
  final ValueChanged<bool> onTabChanged; // Función para cambiar la pestaña

  const CommunityHeader({
    Key? key,
    required this.isPublicTab,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20, 
        left: 20, right: 20, bottom: 20
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Comunidad", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  Text(
                    isPublicTab ? "Descubre recetas de toda la comunidad" : "4 amigos cercanos", 
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CommunitySearchScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.search, color: Colors.white, size: 20),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 45,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(25)),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTabChanged(true), // Avisamos que cambió a Público
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPublicTab ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.public, size: 18, color: isPublicTab ? primaryColor : Colors.white),
                            const SizedBox(width: 8),
                            Text("Público", style: TextStyle(fontWeight: FontWeight.bold, color: isPublicTab ? primaryColor : Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTabChanged(false), // Avisamos que cambió a Amigos
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isPublicTab ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_alt_outlined, size: 18, color: !isPublicTab ? primaryColor : Colors.white),
                            const SizedBox(width: 8),
                            Text("Amigos", style: TextStyle(fontWeight: FontWeight.bold, color: !isPublicTab ? primaryColor : Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}