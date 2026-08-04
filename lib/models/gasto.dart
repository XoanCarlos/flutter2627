class Gasto {
  final String descripcion;
  final double importe;
  final String categoria;
  final DateTime fecha;
  final bool pagado;

  Gasto({
    required this.descripcion,
    required this.importe,
    required this.categoria,
    required this.fecha,
    required this.pagado,
  });
}
