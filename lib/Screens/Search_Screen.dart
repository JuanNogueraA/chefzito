import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            // Robot chef
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(child: Text('🤖', style: TextStyle(fontSize: 60))),
            ),

            SizedBox(height: 24),

            // Título
            Text(
              '¿Qué tienes en casa?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8),

            // Subtítulo
            Text(
              'Añade tus ingredientes o escanéalos con la cámara',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 24),

            // Tarjeta de Escaneo IA
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF9C27B0).withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Escaneo Inteligente con IA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Toma una foto de tus ingredientes',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Botón escanear
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Color(0xFF9C27B0)),
                          SizedBox(width: 8),
                          Text(
                            'Escanear Ingredientes',
                            style: TextStyle(
                              color: Color(0xFF9C27B0),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Separador
            Row(
              children: [
                Expanded(child: Divider(indent: 40, endIndent: 20)),
                Text(
                  'O escribe manualmente',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                Expanded(child: Divider(indent: 20, endIndent: 40)),
              ],
            ),

            SizedBox(height: 20),

            // Campo de búsqueda
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ej: Pollo, tomate, pasta...',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.search, color: Colors.grey[400]),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF5722),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Ingredientes comunes
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ingredientes comunes:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _IngredientChip(label: 'Pollo'),
                      _IngredientChip(label: 'Pasta'),
                      _IngredientChip(label: 'Tomate'),
                      _IngredientChip(label: 'Cebolla'),
                      _IngredientChip(label: 'Ajo'),
                      _IngredientChip(label: 'Arroz'),
                      _IngredientChip(label: 'Huevos'),
                      _IngredientChip(label: 'Queso'),
                      _IngredientChip(label: 'Leche'),
                      _IngredientChip(label: 'Pan'),
                      _IngredientChip(label: 'Aceite'),
                      _IngredientChip(label: 'Sal'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // Imagen de la olla
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🍲', style: TextStyle(fontSize: 60))),
            ),

            SizedBox(height: 20),

            // Texto final
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Empieza añadiendo ingredientes para\ndescubrir recetas increíbles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}

// Widget para los chips de ingredientes
class _IngredientChip extends StatelessWidget {
  final String label;

  const _IngredientChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
