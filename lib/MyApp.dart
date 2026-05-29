import 'package:flutter/material.dart';
import 'package:chefzito/Screens/Auth/Splash_Screen.dart';
import 'package:chefzito/Screens/Auth/Welcome_Screen.dart';
import 'package:chefzito/Screens/Auth/Login_Screen.dart';
import 'package:chefzito/Screens/Home/Home_Screen.dart';
import 'package:chefzito/Screens/Search/Search_Screen.dart';
import 'package:chefzito/Screens/Community/Community_Screen.dart';
import 'package:chefzito/Screens/Rankings/Rankings_Screen.dart';
import 'package:chefzito/Screens/Profile/Profile_Screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chefzito',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
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
