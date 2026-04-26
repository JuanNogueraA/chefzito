import 'package:flutter/material.dart';

class ProfileBottomNavBar extends StatelessWidget {
  const ProfileBottomNavBar({super.key});

  void _navigate(BuildContext context, int index) {
    final routes = <int, String>{
      0: '/home',
      1: '/buscar',
      2: '/social',
      3: '/rankings',
      4: '/perfil',
    };

    final targetRoute = routes[index];
    if (targetRoute == null) {
      return;
    }

    Navigator.pushReplacementNamed(context, targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange[400],
      unselectedItemColor: Colors.grey[600],
      onTap: (index) => _navigate(context, index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervisor_account_sharp),
          label: 'Social',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Rankings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Perfil',
        ),
      ],
    );
  }
}
