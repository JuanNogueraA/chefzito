import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';
// ¡Importamos nuestras nuevas piezas de Lego!
import '../Widgets/Community_Screen_Widgets/Community_Header.dart';
import '../Widgets/Community_Screen_Widgets/Friends_Stories.dart';
import '../Widgets/Community_Screen_Widgets/Post_Card.dart';
import '../Widgets/Community_Screen_Widgets/Create_Post_Modal.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isPublicTab = true;

  Color get primaryColor => isPublicTab ? const Color(0xFFFF5E00) : const Color(0xFF8A2BE2);
  Color get secondaryColor => isPublicTab ? const Color(0xFFFF2A55) : const Color(0xFF4169E1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // 1. EL HEADER LIMPIO
          CommunityHeader(
            isPublicTab: isPublicTab,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            onTabChanged: (bool isPublic) {
              setState(() => isPublicTab = isPublic);
            },
          ),
          
          // 2. LA LISTA DE CONTENIDO
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                if (!isPublicTab) FriendsStories(primaryColor: primaryColor),
                
                if (isPublicTab) const PostCard(
                  userName: "María García",
                  userHandle: "@mariachef",
                  time: "hace 2h",
                  recipeName: "Pasta Carbonara",
                  likes: "234",
                  caption: "¡Mi primera carbonara siguiendo la receta de Chefzito! Quedó increíble 🤤",
                  imageUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=1000&auto=format&fit=crop',
                  isFriend: true,
                ),
                
                if (!isPublicTab) const PostCard(
                  userName: "Carlos Ruiz",
                  userHandle: "@carloscocina",
                  time: "hace 3h",
                  recipeName: "Bowl Mediterráneo",
                  likes: "45",
                  caption: "Solo para mis amigos cercanos 💚 Receta especial que he perfeccionado",
                  imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1000&auto=format&fit=crop',
                  isFriend: true,
                  isPrivate: true,
                ),
                
                if (isPublicTab) const PostCard(
                  userName: "Chef Viajero",
                  userHandle: "@chefviajero",
                  time: "hace 5h",
                  recipeName: "Salmón a la parrilla",
                  likes: "156",
                  caption: "Mi receta favorita del mes.",
                  imageUrl: 'https://images.unsplash.com/photo-1485921325833-c519f76c4927?q=80&w=1000&auto=format&fit=crop',
                  isFriend: false,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      
      // 3. EL BOTÓN FLOTANTE CON EL MODAL IMPORTADO
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreatePostModal(
            context: context,
            isPublicTab: isPublicTab,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            onTabChanged: (bool isPublic) {
              setState(() => isPublicTab = isPublic);
            },
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 4,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [primaryColor, secondaryColor], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      
      bottomNavigationBar: Navbar(),
    );
  }
}