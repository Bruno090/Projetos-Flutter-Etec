import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'gastos.dart';
import 'agenda.dart';
import 'contatos.dart';

class dataBaseHelper {
  Future<Database> conectaDB() async {
    return openDatabase(join(await getDatabasesPath(), 'Agenda6.db'), version: 1,
      onCreate: (Database db, version) async {
        db.execute("""
        CREATE TABLE Agenda (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT  NULL,
        assunto TEXT NOT NULL)""");

        db.execute("""
        CREATE TABLE Gastos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        despesas TEXT NOT NULL,
        data text NOT NULL,
        valor text NOT NULL)""");

        db.execute("""
        CREATE TABLE Contato (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        fone TEXT NOT NULL,
        email TEXT NOT NULL)""");
      });
  }

  Future insertGasto(Gastos gastos) async {
  final Database db = await conectaDB();
  await db.insert('Gastos', gastos.toMap());
}

  Future updateGasto(Gastos gastos) async {
  final Database db = await conectaDB();
  await db.update('Gastos', gastos.toMap(), where: "id = ?", whereArgs: [gastos.id]);
}

  Future deleteGasto(int id) async {
  final Database db = await conectaDB();
  await db.delete('Gastos',  where: "id = ?", whereArgs: [id]);
}

  Future<List<Gastos>>consultaGasto() async {
  final Database db = await conectaDB();
  final List<Map<String, Object?>> queryResult = await db.query('Gastos');
  return queryResult.map((e) => Gastos.fromMap(e)).toList();
}
// Começa Agenda
  Future insertAgeda(Agenda agenda) async {
  final Database db = await conectaDB();
  await db.insert('Agenda', agenda.toMap());
}

  Future updateAgenda(Agenda agenda) async {
  final Database db = await conectaDB();
  await db.update('Agenda', agenda.toMap(), where: "id = ?", whereArgs: [agenda.id]);
}

  Future deleteAgenda(int id) async {
  final Database db = await conectaDB();
  await db.delete('Agenda',  where: "id = ?", whereArgs: [id]);
}

  Future<List<Agenda>>consultaAgenda() async {
  final Database db = await conectaDB();
  final List<Map<String, Object?>> queryResult = await db.query('agenda');
  return queryResult.map((e) => Agenda.fromMap(e)).toList();
}

//Começa Contato
Future insertContato(Contato contato) async {
  final Database db = await conectaDB();
  await db.insert('contato', contato.toMap());
}

  Future updateContato(Contato contato) async {
  final Database db = await conectaDB();
  await db.update('contato', contato.toMap(), where: "id = ?", whereArgs: [contato.id]);
}

  Future deleteContato(int id) async {
  final Database db = await conectaDB();
  await db.delete('Contato',  where: "id = ?", whereArgs: [id]);
}

  Future<List<Contato>>consultaContato() async {
  final Database db = await conectaDB();
  final List<Map<String, Object?>> queryResult = await db.query('Contato');
  return queryResult.map((e) => Contato.fromMap(e)).toList();
}

}