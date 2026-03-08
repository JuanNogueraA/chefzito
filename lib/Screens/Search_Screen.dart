import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Placeholder(), bottomNavigationBar: Navbar()),
    );
  }
}
