import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';

// Nuestras piezas
import '../Widgets/Rankings_Screen_Widgets/Ranking_Tab_Button.dart';
import '../Widgets/Rankings_Screen_Widgets/Current_List.dart';
import '../Widgets/Rankings_Screen_Widgets/Weekly_Banner.dart';

class RankingsScreen extends StatefulWidget {
  const RankingsScreen({Key? key}) : super(key: key);

  @override
  State<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends State<RankingsScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // HEADER CON DEGRADADO Y TABS
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20, right: 20, bottom: 20
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD500F9), Color(0xFFFF4081)],
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
                        Row(
                          children: const [
                            Icon(Icons.emoji_events, color: Colors.white, size: 28),
                            SizedBox(width: 8),
                            Text("Rankings", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text("Lo mejor de la comunidad", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                      child: const Icon(Icons.smart_toy, color: Colors.white, size: 40),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                // TABS
                Container(
                  height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      RankingTabButton(title: "Recetas", icon: Icons.menu_book, isActive: selectedTab == 0, onTap: () => setState(() => selectedTab = 0)),
                      RankingTabButton(title: "Chefs", icon: Icons.workspace_premium, isActive: selectedTab == 1, onTap: () => setState(() => selectedTab = 1)),
                      RankingTabButton(title: "Ingredientes", icon: Icons.eco, isActive: selectedTab == 2, onTap: () => setState(() => selectedTab = 2)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // CUERPO DE LA LISTA Y BANNER
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: [
                CurrentList(selectedTab: selectedTab),
                const SizedBox(height: 10),
                const WeeklyBanner(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}