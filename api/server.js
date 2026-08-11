const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');
const bcrypt = require('bcrypt');

const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createPool({
  host: 'localhost',
  user: 'user',
  password: 'abc123',
  database: 'bbdd',
  port: 3306,
});

app.get('/', (req, res) => {
  res.json({
    mensaje: 'API de Control de Gastos funcionando',
  });
});

// Endpoint para registrar un nuevo usuario

app.post('/usuarios', async (req, res) => {
  try {
    const { nombre, email, password } = req.body;

    const passwordHash = await bcrypt.hash(password, 10);

    const [resultado] = await db.execute(
      'INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)',
      [nombre, email, passwordHash]
    );

    res.status(201).json({
      ok: true,
      mensaje: 'Usuario registrado correctamente',
      id: resultado.insertId,
    });
  } catch (error) {
    console.error(error);
    if (error.code === 'ER_DUP_ENTRY') {
      res.status(409).json({
        ok: false,
        mensaje: 'El email ya está registrado',
      });
    } else {
      res.status(500).json({
        ok: false,
        mensaje: 'Error al registrar el usuario',
      });
    }
  }
});

app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const [usuarios] = await db.execute(
      'SELECT * FROM usuarios WHERE email = ?',
      [email]
    );

    if (usuarios.length === 0) {
      return res.status(401).json({
        ok: false,
        mensaje: 'Correo electrónico o contraseña incorrectos',
      });
    }

    const usuario = usuarios[0];
    
    const passwordCorrecta = await bcrypt.compare(
      password,
      usuario.password
    
    );

    if (!passwordCorrecta) {
      return res.status(401).json({
        ok: false,
        mensaje: 'Correo electrónico o contraseña incorrectos',
      });
    }
    
    res.status(200).json({
      ok: true,
      mensaje: 'Inicio de sesión correcto',
      usuario: {
        id: usuario.id,
        nombre: usuario.nombre,
        email: usuario.email,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error en el servidor',
    });
  }
});


app.listen(3000, () => {
  console.log('API REST funcionando en http://localhost:3000');
});
