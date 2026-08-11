import 'package:flutter/material.dart';
import 'package:flutter2627/pages/listado_gastos_page.dart';

class MenuGastosPage extends StatelessWidget {
  final String nombreUsuario;
  const MenuGastosPage({
    super.key,
    required this.nombreUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Gastos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 30),

              Text(
                'Hola, $nombreUsuario 👋',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payments),
                  label: const Text(
                    'Gastos',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    // Próximamente
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.euro),
                  label: const Text(
                    'Ingresos',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    // Próximamente
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.bar_chart),
                  label: const Text(
                    'Estadísticas',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListadoGastosPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
