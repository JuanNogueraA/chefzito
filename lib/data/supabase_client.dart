import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_config.dart';

/// Clase proveedora encargada de gestionar la conexión con Supabase.
class SupabaseClientProvider {
  /// Inicializa la instancia global de Supabase con las credenciales configuradas.
  /// Debe llamarse antes de ejecutar [runApp] en main.dart.
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.anonKey,
    );
  }

  /// Getter estático para obtener el cliente de Supabase instanciado.
  /// Facilita el acceso a la base de datos y autenticación desde cualquier lugar de la app.
  static SupabaseClient get client => Supabase.instance.client;
}
