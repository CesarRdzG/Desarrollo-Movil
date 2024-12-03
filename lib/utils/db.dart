import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE reservations (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        eventDate TEXT,  
        time INTEGER,    
        team TEXT,       
        rival TEXT,      
        place INTEGER,   
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'reservations.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await database.execute("""
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            fullName TEXT NOT NULL,
            phoneNumber TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        """);
        }
      },
    );
  }

  ///FUNCIONES DE RESERVACION
  // Create new item
  static Future<int> createReservation(Map<String, dynamic> reservation) async {
    final db = await DatabaseHelper.db();

    final data = {
      'eventDate': reservation['eventDate']?.toIso8601String(),
      'time': reservation['time'],
      'team': reservation['team'],
      'rival': reservation['rival'],
      'place': reservation['place'],
    };

    final id = await db.insert('reservations', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getReservations() async {
    final db = await DatabaseHelper.db();
    final result = await db.query('reservations', orderBy: "id");

    return result.map((reservation) {
      return {
        'id': reservation['id'],
        'eventDate': reservation['eventDate'] != null && reservation['eventDate'] is String
            ? DateTime.parse(reservation['eventDate'] as String)
            : null,
        'time': reservation['time'],
        'team': reservation['team'],
        'rival': reservation['rival'],
        'place': reservation['place'],
      };
    }).toList();
  }
  ///FUNCIONES DE USUARIOS
  //Registrar usuarios
  static Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await DatabaseHelper.db();

    final data = {
      'fullName': user['fullName'],
      'phoneNumber': user['phoneNumber'],
      'password': user['password'],
    };

    try {
      final id = await db.insert('users', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      return id;
    } catch (e) {
      debugPrint("Error al registrar usuario: $e");
      return -1;
    }
  }
  //Verificar usuarios
  static Future<Map<String, dynamic>?> loginUser(String phoneNumber, String password) async {
    final db = await DatabaseHelper.db();


    final result = await db.query(
      'users',
      where: 'phoneNumber = ? AND password = ?',
      whereArgs: [phoneNumber, password],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}