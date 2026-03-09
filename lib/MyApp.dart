import 'package:flutter/material.dart';
import 'package:chefzito/Screens/Welcome_Screen.dart';
import 'package:chefzito/Screens/Login_Screen.dart';
import 'package:chefzito/Screens/Home_Screen.dart';
import 'package:chefzito/Screens/Search_Screen.dart';
import 'package:chefzito/Screens/Community_Screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/buscar': (context) => SearchScreen(),
        '/social': (context) => CommunityScreen(),
        '/rankings': (context) => RankingsScreen(),
        '/perfil': (context) => ProfileScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
