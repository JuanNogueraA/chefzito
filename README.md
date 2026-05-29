# Chefzito 👨‍🍳

> **Una aplicación móvil innovadora para compartir recetas, descubrir ingredientes y conectar con otros chefs aficionados.**

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-1e88e5?logo=dart)
![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3fcf8e?logo=supabase)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active%20Development-brightgreen)

## 📋 Descripción del Proyecto

**Chefzito** es una plataforma social móvil diseñada para chefs aficionados que desean compartir sus recetas, descubrir nuevos sabores del mundo y conectarse con una comunidad culinaria global. La aplicación permite crear, compartir y guardar recetas con imágenes, ingredientes detallados, pasos de preparación y estadísticas de engagement.

### Características Principales

- 🎯 **Gestión de Recetas Completa**: Crear, editar, eliminar y compartir recetas
- 🔍 **Búsqueda Inteligente**: Buscar recetas por ingredientes disponibles
- 🤖 **IA Integrada**: Detección de ingredientes por imagen y generación de recetas con IA
- 👥 **Red Social**: Seguir a otros chefs, interactuar mediante likes y comentarios
- 💾 **Sistema de Guardados**: Guardar recetas favoritas para acceso rápido
- 🏆 **Logros y Rankings**: Sistema de gamificación para motivar participación
- 📱 **Perfil Personalizado**: Gestión completa del perfil de usuario
- 💬 **Chat de Recetas**: Conversación con IA para sugerencias culinarias

---

## 🏗️ Arquitectura del Proyecto

### Patrón Hexagonal (Arquitectura Limpia)

```
lib/
├── core/
│   ├── application/        # Casos de uso (UseCases)
│   │   └── use_cases/
│   │       ├── profile_use_cases.dart
│   │       └── ...
│   ├── domain/             # Entidades y puertos (Interfaces)
│   │   └── ports/
│   │       ├── profile_port.dart
│   │       ├── recipe_port.dart
│   │       ├── auth_port.dart
│   │       └── ...
│   └── infrastructure/     # Implementaciones (Adaptadores)
│       └── supabase/
│           └── supabase_chefzito_adapter.dart
├── models/                 # Modelos de datos
├── services/              # Servicios principales
│   └── chefzito_service.dart
├── data/                  # Configuración de base de datos
├── Screens/               # Pantallas de la aplicación
├── Widgets/               # Componentes reutilizables
└── main.dart             # Punto de entrada
```

### Principios Aplicados

- ✅ **Separación de Responsabilidades**: Domain, Application, Infrastructure
- ✅ **Inversión de Dependencias**: Uso de puertos/interfaces
- ✅ **Inyección de Dependencias**: Adaptadores desacoplados
- ✅ **Testabilidad**: Lógica independiente de frameworks

---

## 🛠️ Tecnologías Utilizadas

### Frontend
- **Flutter 3.x** - Framework multiplataforma
- **Dart 3.x** - Lenguaje de programación
- **Provider/StateManagement** - Gestión de estado

### Backend & Base de Datos
- **Supabase** - Backend as a Service (PostgreSQL)
- **PostgreSQL** - Base de datos relacional
- **Row Level Security (RLS)** - Seguridad a nivel de fila
- **Supabase Storage** - Almacenamiento de imágenes

### Integraciones IA
- **Google Gemini API** - Detección de ingredientes y generación de recetas
- **Cloud Functions** - Funciones serverless para IA

### Herramientas de Desarrollo
- **Git** - Control de versiones
- **Flutter CLI** - Herramientas de desarrollo
- **VS Code** - IDE principal

---

## 📊 Estructura de Base de Datos

### Tablas Principales

```sql
-- Usuarios
users (id, username, email, bio, avatar_url, followers_count, following_count)

-- Recetas
recipes (id, author_id, title, description, cover_image_url, prep_time_min, 
         servings, difficulty, visibility, likes_count, saves_count)

-- Pasos de Recetas
recipe_steps (id, recipe_id, step_number, instruction, image_url)

-- Ingredientes
ingredients_master (id, name, normalized_name, category, image_url)
recipe_ingredients (id, recipe_id, ingredient_id, quantity, unit, optional)

-- Interacciones Sociales
posts (id, user_id, recipe_id, media_url, caption, likes_count)
post_likes (user_id, post_id, created_at)
post_comments (id, post_id, user_id, comment, created_at)
user_follows (follower_id, following_id, created_at)

-- Recetas Guardadas
saved_recipes (user_id, recipe_id, created_at)

-- Recomendaciones IA
ai_recommendations (id, user_id, recipe_id, score, reason)
chat_sessions (id, user_id, ingredients_snapshot)
chat_messages (id, session_id, role, content, suggested_recipe_id)

-- Notificaciones
notifications (id, user_id, actor_id, type, is_read)
```

### Políticas de Seguridad

- ✅ **Row Level Security Habilitado**: Usuarios solo ven datos públicos o propios
- ✅ **Autenticación con Supabase Auth**: Sistema de login/registro seguro
- ✅ **Buckets de Almacenamiento Públicos**: Imágenes accesibles vía URL
- ✅ **Triggers Automáticos**: Actualización de timestamps

---

## 🎯 Funcionalidades Implementadas

### Autenticación
- ✅ Login con email/contraseña
- ✅ Registro de nuevos usuarios
- ✅ Gestión de sesiones
- ✅ Logout seguro

### Gestión de Perfil
- ✅ Visualización de perfil personalizado
- ✅ Edición de información del usuario
- ✅ Carga de avatar personalizado
- ✅ Estadísticas del usuario (recetas, seguidores, likes)
- ✅ Logros y badges del mes

### Recetas
- ✅ Crear recetas con título, descripción, ingredientes y pasos
- ✅ Subir imagen de portada desde galería o cámara
- ✅ Ver detalles completos de recetas
- ✅ Listar "Mis Recetas" en el perfil
- ✅ Sistema de dificultad (fácil, medio, difícil)
- ✅ Registro de tiempo de preparación

### Descubrimiento Inteligente
- ✅ **Detección por Imagen**: Tomar foto de ingredientes → detectar automáticamente
- ✅ **Generación IA**: Crear recetas basadas en ingredientes disponibles
- ✅ **Búsqueda por Ingredientes**: Filtrar recetas por lo que tienes disponible

### Comunidad
- ✅ Seguir/dejar de seguir a otros chefs
- ✅ Ver posts de otros usuarios
- ✅ Like en recetas y posts
- ✅ Comentarios en posts
- ✅ Rankings de ingredientes populares

### Sistema de Guardados
- ✅ Guardar recetas favoritas
- ✅ Acceso rápido desde "Guardadas" en perfil
- ✅ Sincronización en tiempo real

---

## 🚀 Instalación y Configuración

### Requisitos Previos

```bash
# Flutter SDK
flutter --version  # Debe ser 3.0+

# Dart SDK
dart --version    # Viene con Flutter

# Git
git --version
```

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/tu-usuario/chefzito.git
cd chefzito
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar Supabase**
   - Crear cuenta en [supabase.com](https://supabase.com)
   - Crear nuevo proyecto
   - Obtener URL y ANON_KEY
   - Crear archivo `.env` (no commitar):
   ```
   SUPABASE_URL=tu_url
   SUPABASE_ANON_KEY=tu_key
   ```

4. **Ejecutar la aplicación**
```bash
flutter run
```

### Configuración de Base de Datos

Ejecutar el script SQL proporcionado en `Database_Sql.md`:
```bash
# En Supabase SQL Editor
# Copiar y ejecutar todo el contenido de Database_Sql.md
```

---

## 📁 Estructura de Carpetas Detallada

```
chefzito/
├── lib/
│   ├── core/
│   │   ├── application/
│   │   │   └── use_cases/
│   │   │       ├── profile_use_cases.dart
│   │   │       └── ...
│   │   ├── domain/
│   │   │   └── ports/
│   │   │       ├── auth_port.dart
│   │   │       ├── recipe_port.dart
│   │   │       ├── profile_port.dart
│   │   │       ├── community_port.dart
│   │   │       ├── home_port.dart
│   │   │       └── ...
│   │   └── infrastructure/
│   │       └── supabase/
│   │           └── supabase_chefzito_adapter.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── recipe_model.dart
│   │   ├── post_model.dart
│   │   ├── comment_model.dart
│   │   ├── follow_model.dart
│   │   └── trend_model.dart
│   ├── services/
│   │   └── chefzito_service.dart
│   ├── data/
│   │   ├── supabase_client.dart
│   │   └── supabase_config.dart
│   ├── Screens/
│   │   ├── Auth/
│   │   │   ├── Login_Screen.dart
│   │   │   ├── Welcome_Screen.dart
│   │   │   └── Splash_Screen.dart
│   │   ├── Home/
│   │   │   └── Home_Screen.dart
│   │   ├── Profile/
│   │   │   ├── Profile_Screen.dart
│   │   │   └── edit_profile_screen.dart
│   │   ├── Community/
│   │   │   └── Community_Screen.dart
│   │   ├── Rankings/
│   │   │   └── Rankings_Screen.dart
│   │   ├── Search/
│   │   │   └── Search_Screen.dart
│   │   └── Settings/
│   │       └── Settings_Screen.dart
│   ├── Widgets/
│   │   ├── NavBar.dart
│   │   ├── Profile_Screen_Widgets/
│   │   │   ├── Profile_Card.dart
│   │   │   ├── Photo_Grid.dart
│   │   │   ├── Achievements_Card.dart
│   │   │   └── ...
│   │   ├── Community_Screen_Widgets/
│   │   ├── Home_Screen_Widgets/
│   │   └── ...
│   ├── main.dart
│   └── MyApp.dart
├── assets/
│   ├── img/
│   └── data/
├── pubspec.yaml
├── Database_Sql.md
├── README.md
└── analysis_options.yaml
```

---

## 🔐 Seguridad

- 🔒 **Autenticación JWT**: Tokens seguros con Supabase
- 🔐 **Row Level Security**: Control de acceso a nivel de fila
- 🛡️ **Validación de Entrada**: Sanitización en cliente y servidor
- 📱 **HTTPS**: Todas las comunicaciones encriptadas
- 🔑 **Manejo de Secretos**: Variables de entorno para credenciales

---

## 📈 Métricas del Proyecto

- **Líneas de Código**: 5000+
- **Pantallas**: 7 principales
- **Modelos**: 6 entidades principales
- **Tablas BD**: 15+
- **Endpoints**: 30+

---

## 🤝 Contribución

Para contribuir al proyecto:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto está bajo la licencia MIT. Ver archivo `LICENSE` para más detalles.

---

## 👨‍💻 Equipo de Desarrollo

| Rol | Nombre | Email | GitHub/LinkedIn |
|-----|--------|-------|-----------------|
| 👨‍💻 Lead Developer | Jeremy Fontalvo | jeremyj-fontalvom@unilibre.edu.co | [GitHub](https://github.com/Jfer178/) |
| 👨‍💻 Backend Developer | Manuel Rudas | manuel-rudass@unilibre.edu.co | [GitHub](https://github.com/manuel) |
| 👨‍💻 Frontend Developer | Juan Noguera | juanf-nogueraa@unilibre.edu.co | [GitHub](https://github.com/juan) |

---

## 📞 Contacto y Soporte

¿Preguntas o sugerencias?
- 📧 Email: soporte@chefzito.com
- 🐛 Issues: [GitHub Issues](https://github.com/tu-usuario/chefzito/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/tu-usuario/chefzito/discussions)

---

## 🙏 Agradecimientos

- Flutter team por un framework increíble
- Supabase por backend robusto
- Google por Gemini AI
- Comunidad de Flutter

---

**¡Hecho con ❤️ para la comunidad culinaria!**

*Última actualización: Mayo 2026*
