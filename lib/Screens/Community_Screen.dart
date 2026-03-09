import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';
import 'Community_Search_Screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isPublicTab = true;

  Color get primaryColor =>
      isPublicTab ? const Color(0xFFFF5E00) : const Color(0xFF8A2BE2);
  Color get secondaryColor =>
      isPublicTab ? const Color(0xFFFF2A55) : const Color(0xFF4169E1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                if (!isPublicTab) _buildFriendsStories(),
                if (isPublicTab)
                  _buildPostCard(
                    userName: "María García",
                    userHandle: "@mariachef",
                    time: "hace 2h",
                    recipeName: "Pasta Carbonara",
                    likes: "234",
                    caption:
                        "¡Mi primera carbonara siguiendo la receta de Chefzito! Quedó increíble 🤤",
                    imageUrl:
                        'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=1000&auto=format&fit=crop',
                    isFriend: true,
                  ),
                if (!isPublicTab)
                  _buildPostCard(
                    userName: "Carlos Ruiz",
                    userHandle: "@carloscocina",
                    time: "hace 3h",
                    recipeName: "Bowl Mediterráneo",
                    likes: "45",
                    caption:
                        "Solo para mis amigos cercanos 💚 Receta especial que he perfeccionado",
                    imageUrl:
                        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1000&auto=format&fit=crop',
                    isFriend: true,
                    isPrivate: true,
                  ),
                if (isPublicTab)
                  _buildPostCard(
                    userName: "Chef Viajero",
                    userHandle: "@chefviajero",
                    time: "hace 5h",
                    recipeName: "Salmón a la parrilla",
                    likes: "156",
                    caption: "Mi receta favorita del mes.",
                    imageUrl:
                        'https://images.unsplash.com/photo-1485921325833-c519f76c4927?q=80&w=1000&auto=format&fit=crop',
                    isFriend: false,
                  ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostModal(context),
        backgroundColor: Colors.transparent,
        elevation: 4,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

  // WIDGETS INTERNOS (MODULARIZACIÓN)

  Widget _buildHeader() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 20,
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
                  const Text(
                    "Comunidad",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    isPublicTab
                        ? "Descubre recetas de toda la comunidad"
                        : "4 amigos cercanos",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    // Usamos la nueva clase aquí
                    MaterialPageRoute(
                      builder: (context) => const CommunitySearchScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isPublicTab = true),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isPublicTab ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.public,
                              size: 18,
                              color: isPublicTab ? primaryColor : Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Público",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isPublicTab
                                    ? primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isPublicTab = false),
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isPublicTab ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              size: 18,
                              color: !isPublicTab ? primaryColor : Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Amigos",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !isPublicTab
                                    ? primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsStories() {
    List<Map<String, String>> friends = [
      {
        "name": "María",
        "img": "https://randomuser.me/api/portraits/women/44.jpg",
      },
      {
        "name": "Carlos",
        "img": "https://randomuser.me/api/portraits/men/32.jpg",
      },
      {
        "name": "Ana",
        "img": "https://randomuser.me/api/portraits/women/68.jpg",
      },
      {
        "name": "Pedro",
        "img": "https://randomuser.me/api/portraits/men/45.jpg",
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: friends
              .map(
                (f) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(f["img"]!),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        f["name"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPostCard({
    required String userName,
    required String userHandle,
    required String time,
    required String recipeName,
    required String likes,
    required String caption,
    required String imageUrl,
    required bool isFriend,
    bool isPrivate = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/lego/1.jpg',
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$userHandle • $time",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (isFriend && !isPrivate)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person_add_alt_1,
                          color: Colors.green,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Amigo",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 10),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isPrivate
                      ? Colors.blue
                      : Colors.orange.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 16,
                    color: isPrivate ? Colors.blue : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    recipeName,
                    style: TextStyle(
                      color: isPrivate ? Colors.blue : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (isPrivate)
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ), // Tag extra para amigos
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.lock_outline, size: 14, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Solo Amigos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.favorite_border, size: 28),
                const SizedBox(width: 15),
                const Icon(Icons.chat_bubble_outline, size: 26),
                const Spacer(),
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "$likes me gusta",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: "$userHandle ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: caption),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Ver los comentarios",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // MODAL INFERIOR (CREAR PUBLICACIÓN)

  void _showCreatePostModal(BuildContext context) {
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Crear Publicación",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                          const Text(
                            "Privacidad de la publicación",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              _buildPrivacyOption(
                                icon: Icons.public,
                                title: "Público",
                                subtitle: "Todos pueden ver",
                                isActive: isPublicTab,
                                color: const Color(0xFFFF5E00),
                                onTap: () => setModalState(() {
                                  setState(() => isPublicTab = true);
                                }),
                              ),
                              const SizedBox(width: 15),
                              _buildPrivacyOption(
                                icon: Icons.people_alt_outlined,
                                title: "Solo Amigos",
                                subtitle: "Solo tus amigos",
                                isActive: !isPublicTab,
                                color: const Color(0xFF8A2BE2),
                                onTap: () => setModalState(() {
                                  setState(() => isPublicTab = false);
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Foto de tu platillo",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Toca para subir foto",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "JPG, PNG hasta 10MB",
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Nombre de la receta",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Ej: Pasta Carbonara",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Descripción",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Cuéntanos sobre tu platillo...",
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.6),
                                  secondaryColor.withOpacity(0.6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  isPublicTab
                                      ? "Publicar Públicamente"
                                      : "Publicar para Amigos",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
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
          },
        );
      },
    );
  }

  Widget _buildPrivacyOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? color : Colors.grey[300]!,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Icon(icon, color: isActive ? color : Colors.grey[400], size: 30),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? color : Colors.grey[800],
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
