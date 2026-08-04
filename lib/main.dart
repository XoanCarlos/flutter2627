import 'package:flutter/material.dart';
import 'package:flutter2627/pages/nuevo_gasto_page.dart';
import 'package:flutter2627/models/gasto.dart';

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
class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  // Lista de gastos (inicialmente vacía).
  final List<Gasto> gastos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior.
      appBar: AppBar(
        title: const Text('Control de Gastos'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),

      // Si no hay gastos registrados, se muestra la pantalla de bienvenida.
      // En caso contrario, se visualiza la lista de gastos.
      body: gastos.isEmpty
          ? Center(
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

                    // Título de bienvenida.
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Texto descriptivo.
                    Text(
                      'Gestiona tus gastos personales\n'
                      'de forma sencilla y eficiente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            )
          // Si existen gastos, se muestran mediante una lista dinámica.
          : ListView.builder(
              // Número total de elementos de la lista.
              itemCount: gastos.length,

              // Construye automáticamente cada elemento de la lista.
              itemBuilder: (context, index) {
                // Obtiene el gasto correspondiente a la posición actual.
                final gasto = gastos[index];

                return Card(
                  // Margen exterior de la tarjeta.
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(
                    // Icono que identifica el gasto.
                    leading: const Icon(Icons.payments),

                    // Descripción del gasto.
                    title: Text(gasto.descripcion),

                    // Categoría y fecha del gasto.
                    subtitle: Text(
                      '${gasto.categoria} · '
                      '${gasto.fecha.day}/${gasto.fecha.month}/${gasto.fecha.year}',
                    ),

                    // Importe mostrado con dos decimales.
                    trailing: IconButton(
                      // Icono para eliminar el gasto.
                      icon: const Icon(Icons.delete, color: Colors.red),

                      onPressed: () {
                        // Elimina el gasto seleccionado.
                        setState(() {
                          gastos.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      // Botón flotante para añadir un nuevo gasto.
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Abre el formulario y espera el objeto devuelto.
          final Gasto? nuevoGasto = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NuevoGastoPage()),
          );

          // Si se ha recibido un gasto, lo añade a la colección.
          if (nuevoGasto != null) {
            setState(() {
              gastos.add(nuevoGasto);
            });
          }
        },

        child: const Icon(Icons.add),
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
