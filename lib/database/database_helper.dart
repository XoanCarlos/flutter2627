import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter2627/models/gasto.dart';

// Clase encargada de gestionar la base de datos SQLite de la aplicación.
class DatabaseHelper {
  // Variable que almacenará la conexión con la base de datos.
  Database? _database;

  // Devuelve la conexión con la base de datos.
  // Si todavía no existe, la crea automáticamente.
  Future<Database> get database async {
    // Si la base de datos ya está creada, la devuelve.
    if (_database != null) {
      return _database!;
    }

    // En caso contrario, crea la base de datos y almacena la conexión.
    _database = await _initDatabase();

    return _database!;
  }

  // Crea o abre la base de datos.
  Future<Database> _initDatabase() async {
    // Obtiene la carpeta donde Flutter almacena las bases de datos.
    String ruta = await getDatabasesPath();

    // Construye la ruta completa del archivo de la base de datos.
    String path = join(ruta, 'bbdd.db');

    // Abre la base de datos.
    // Si no existe, SQLite la creará automáticamente.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Crea la tabla "gastos" si no existe.
        await db.execute('''
          CREATE TABLE gastos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT NOT NULL,
            importe REAL NOT NULL,
            categoria TEXT NOT NULL,
            fecha TEXT NOT NULL,
            pagado INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // Inserta un nuevo gasto en la base de datos.
  Future<void> insertarGasto(Gasto gasto) async {
    // Obtiene la conexión con la base de datos.
    // recuerda si no existe la database la crea y también la tabla
    final db = await database;
    // Inserta el gasto en la tabla "gastos".
    await db.insert(
      // Nombre de la tabla.
      'gastos',
      // Convierte el objeto Gasto en un Map.
      gasto.toMap(),
    );
  }

  // Recupera todos los gastos almacenados en la tabla "gastos".
  Future<List<Map<String, dynamic>>> obtenerGastos() async {
    // Obtiene la conexión con la base de datos.
    final db = await database;
    // Devuelve todos los registros de la tabla gastos.
    return await db.query('gastos');
  }

  // Elimina un gasto de la base de datos a partir de su identificador.
  Future<int> eliminarGasto(int id) async {
    // Obtiene la conexión con la base de datos.
    final db = await database;
    // Elimina el registro cuyo identificador coincide.
    return await db.delete('gastos', where: 'id = ?', whereArgs: [id]);
  }

  // Actualiza un gasto existente en la base de datos.
  Future<int> actualizarGasto(Gasto gasto) async {
    // Obtiene la conexión con la base de datos.
    final db = await database;
    // Actualiza el registro cuyo identificador coincide.
    return await db.update(
      'gastos',
      gasto.toMap(),
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }
}
