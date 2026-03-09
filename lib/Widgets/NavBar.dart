import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _getSelectedIndex() {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/buscar':
        return 1;
      case '/social':
        return 2;
      case '/rankings':
        return 3;
      case '/perfil':
        return 4;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    // Obtener la ruta actual
    final currentRoute = ModalRoute.of(context)?.settings.name;
    String targetRoute = '';

    switch (index) {
      case 0:
        targetRoute = '/home';
        break;
      case 1:
        targetRoute = '/buscar';
        break;
      case 2:
        targetRoute = '/social';
        break;
      case 3:
        targetRoute = '/rankings';
        break;
      case 4:
        targetRoute = '/perfil';
        break;
    }

    // Solo navegar si la ruta destino es diferente a la actual
    if (currentRoute != targetRoute) {
      Navigator.pushReplacementNamed(context, targetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange[400],
      unselectedItemColor: Colors.grey[600],
      onTap: _onItemTapped,
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
