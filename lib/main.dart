import 'package:flutter/material.dart';
import 'package:flutter2627/pages/nuevo_gasto_page.dart';

void main() {
  runApp(const MyApp());
}

// Widget principal de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Gastos',
      debugShowCheckedModeBanner: false,

      // Tema general de la aplicación.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),

      home: const InicioPage(),
    );
  }
}

// Pantalla principal de la aplicación.
class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior.
      appBar: AppBar(
        title: const Text('Control de Gastos'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      // Contenido principal.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono principal.
              const Icon(
                Icons.account_balance_wallet,
                size: 120,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              // Título.
              const Text(
                'Bienvenido',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Texto descriptivo.
              Text(
                'Gestiona tus gastos personales\n'
                'de forma sencilla y eficiente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),

              const SizedBox(height: 40),

              // Botón principal.
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NuevoGastoPage(),
                      ),
                    );
                  },

                  icon: const Icon(Icons.add),

                  label: const Text(
                    'Nuevo Gasto',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Barra de navegación inferior.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }
}
