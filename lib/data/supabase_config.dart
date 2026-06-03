/// Configuración estática de las credenciales de Supabase.
/// Nota de seguridad: En un entorno de producción, las claves sensibles 
/// no deberían estar quemadas (hardcoded) en el código fuente, sino en variables de entorno (.env).
class SupabaseConfig {
  /// URL del proyecto en Supabase
  static const String supabaseUrl =
      'https://tspvvumqbjnpwmabadwp.supabase.co';
      
  /// Clave pública (anon key) para el acceso a la API de Supabase
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRzcHZ2dW1xYmpucHdtYWJhZHdwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg4ODcwOTAsImV4cCI6MjA5NDQ2MzA5MH0.B5WE9thwI5rtrO7qd-AU84stJ8dcDD09niDtQbC_Alw';
}
