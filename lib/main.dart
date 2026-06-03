import 'package:flutter/material.dart';

import 'MyApp.dart';
import 'data/supabase_client.dart';

/// Punto de entrada principal de la aplicación Chefzito.
Future<void> main() async {
  // Asegura que los bindings de Flutter estén inicializados antes de ejecutar código asíncrono.
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la conexión con Supabase (Base de datos y Autenticación).
  await SupabaseClientProvider.initialize();

  // Ejecuta la aplicación inflando el widget raíz (MyApp).
  runApp(const MyApp());
}
