import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Placeholder(),
        bottomNavigationBar: Navbar(),
      ),
    );
  }
}
