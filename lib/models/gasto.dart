class Gasto {
  // Identificador único del registro en SQLite.
  final int? id;

  final String descripcion;
  final double importe;
  final String categoria;
  final DateTime fecha;
  final bool pagado;

  Gasto({
    this.id,
    required this.descripcion,
    required this.importe,
    required this.categoria,
    required this.fecha,
    required this.pagado,
  });

  // Crea un objeto Gasto a partir de un registro obtenido de SQLite.
  factory Gasto.fromMap(Map<String, dynamic> map) {
    return Gasto(
      id: map['id'],
      // Recupera la descripción del gasto.
      descripcion: map['descripcion'],

      // Recupera el importe.
      importe: map['importe'],

      // Recupera la categoría.
      categoria: map['categoria'],

      // Convierte la cadena de texto en un objeto DateTime.
      fecha: DateTime.parse(map['fecha']),

      // Convierte 1 en true y 0 en false.
      pagado: map['pagado'] == 1,
    );
  }
  // Convierte el objeto Gasto en un Map para poder almacenarlo en SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // La clave coincide con el nombre de la columna de la tabla.
      'descripcion': descripcion,

      // Importe del gasto.
      'importe': importe, 

      // Categoría del gasto.
      'categoria': categoria,

      // La fecha se almacena como una cadena de texto.
      'fecha': fecha.toIso8601String(),

      // SQLite no dispone de un tipo booleano.
      // true se almacena como 1 y false como 0.
      'pagado': pagado ? 1 : 0,
    };
  }
}
