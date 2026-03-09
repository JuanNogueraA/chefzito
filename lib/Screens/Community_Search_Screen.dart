import 'package:flutter/material.dart';

class CommunitySearchScreen extends StatefulWidget {
  const CommunitySearchScreen({Key? key}) : super(key: key);

  @override
  State<CommunitySearchScreen> createState() => _CommunitySearchScreenState();
}

class _CommunitySearchScreenState extends State<CommunitySearchScreen> {
  // Estado para saber qué filtro está seleccionado: 0=Todo, 1=Personas, 2=Recetas
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ==========================================
          // HEADER CON DEGRADADO Y BUSCADOR
          // ==========================================
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10, // Respeta el notch/barra de estado
              left: 15, right: 15, bottom: 15
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF5E00), Color(0xFFFFB000)], // Naranja a Amarillo
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [
                // Fila 1: Botón X y Título
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context), // Cierra esta pantalla
                      child: const Icon(Icons.close, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Buscar",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                
                // Fila 2: Barra de búsqueda blanca
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar personas o recetas...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12), // Centra el texto verticalmente
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Fila 3: Filtros (Todo, Personas, Recetas)
                Row(
                  children: [
                    _buildFilterChip("Todo", 0),
                    _buildFilterChip("Personas", 1),
                    _buildFilterChip("Recetas", 2),
                  ],
                ),
              ],
            ),
          ),

          // ==========================================
          // CUERPO: ESTADO VACÍO (EMPTY STATE)
          // ==========================================
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ícono de lupa gigante
                  Icon(
                    Icons.search,
                    size: 80,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 15),
                  // Textos
                  Text(
                    "Busca personas o recetas",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Escribe para comenzar",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET REUTILIZABLE PARA LOS FILTROS
  // ==========================================
  Widget _buildFilterChip(String label, int index) {
    bool isActive = selectedFilter == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Si está activo es blanco, si no, es un blanco transparente
          color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            // Si está activo el texto es naranja, si no, es blanco
            color: isActive ? const Color(0xFFFF5E00) : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}