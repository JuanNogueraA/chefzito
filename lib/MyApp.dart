import 'package:flutter/material.dart';
import 'package:chefzito/Screens/Home_Screen.dart';
import 'package:chefzito/Screens/Search_Screen.dart';

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
        '/': (context) => HomeScreen(),
        '/buscar': (context) => SearchScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
