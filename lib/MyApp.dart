import 'package:flutter/material.dart';
import 'package:chefzito/Screens/Auth/Splash_Screen.dart';
import 'package:chefzito/Screens/Auth/Welcome_Screen.dart';
import 'package:chefzito/Screens/Auth/Login_Screen.dart';
import 'package:chefzito/Screens/Home/Home_Screen.dart';
import 'package:chefzito/Screens/Search/Search_Screen.dart';
import 'package:chefzito/Screens/Community/Community_Screen.dart';
import 'package:chefzito/Screens/Rankings/Rankings_Screen.dart';
import 'package:chefzito/Screens/Profile/Profile_Screen.dart';

/// Widget principal que configura el tema y las rutas de navegación de la aplicación.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // MaterialApp es la raíz de la UI, proporciona navegación y temas de Material Design
    return MaterialApp(
      title: 'Chefzito',
      // Configuración del tema global de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Ruta inicial al abrir la aplicación
      initialRoute: '/',
      // Mapa de rutas con nombre para navegar entre pantallas
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
      // Oculta la etiqueta "DEBUG" en la esquina superior derecha
      debugShowCheckedModeBanner: false,
    );
  }
}
