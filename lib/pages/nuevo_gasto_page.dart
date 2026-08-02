import 'package:flutter/material.dart';

class NuevoGastoPage extends StatefulWidget {
  const NuevoGastoPage({super.key});

  @override
  State<NuevoGastoPage> createState() => _NuevoGastoPageState();
}

class _NuevoGastoPageState extends State<NuevoGastoPage> {
  // Clave para gestionar la validación del formulario.
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos de texto.
  final TextEditingController _descripcionController = TextEditingController();

  final TextEditingController _importeController = TextEditingController();

  // Categoría seleccionada por el usuario.
  String? _categoria;

  // Fecha del gasto (por defecto la fecha actual).
  DateTime _fecha = DateTime.now();

  // Indica si el gasto ya ha sido pagado.
  bool _pagado = false;

  // Lista de categorías disponibles.
  final List<String> _categorias = [
    'Vivienda',
    'Alimentación',
    'Transporte',
    'Ocio',
    'Tecnología',
    'Servicios',
    'Otros',
  ];

  // Muestra el selector de fechas.
  Future<void> _seleccionarFecha() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (fechaSeleccionada != null) {
      setState(() {
        _fecha = fechaSeleccionada;
      });
    }
  }

  // Libera los controladores cuando la pantalla deja de utilizarse.
  @override
  void dispose() {
    _descripcionController.dispose();
    _importeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la pantalla.
      appBar: AppBar(title: const Text('Nuevo gasto')),

      // Formulario de introducción de datos.
      body: Form(
        key: _formKey,

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: ListView(
            children: [
              // Campo para la descripción del gasto.
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Introduzca una descripción';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Campo para introducir el importe.
              TextFormField(
                controller: _importeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Importe',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Introduzca el importe';
                  }

                  if (double.tryParse(valor) == null) {
                    return 'Debe introducir un número válido';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Selector de la categoría del gasto.
              DropdownButtonFormField<String>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                items: _categorias.map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (valor) {
                  setState(() {
                    _categoria = valor;
                  });
                },
                validator: (valor) {
                  if (valor == null) {
                    return 'Seleccione una categoría';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Selector de la fecha.
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Fecha'),
                subtitle: Text('${_fecha.day}/${_fecha.month}/${_fecha.year}'),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  onPressed: _seleccionarFecha,
                ),
              ),

              const SizedBox(height: 10),

              // Indica si el gasto ya ha sido pagado.
              CheckboxListTile(
                title: const Text('Pagado'),
                value: _pagado,
                onChanged: (valor) {
                  setState(() {
                    _pagado = valor!;
                  });
                },
              ),

              const SizedBox(height: 30),

              // Botón para guardar el gasto.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Gasto guardado correctamente'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
