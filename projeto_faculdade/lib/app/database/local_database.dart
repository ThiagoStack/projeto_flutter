import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../models/task_model.dart';
import '../models/user_model.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();

  factory LocalDatabase() => _instance;

  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app_database.db');

    // Deleta o banco de dados existente
    // await deleteDatabase(path);

    // Cria um novo banco de dados
    return await openDatabase(
      path,
      version: 2, // Versão do banco de dados
      onCreate: (db, version) async {
        // Criação da tabela Users
        await db.execute('''
        CREATE TABLE Users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL
        )
        ''');

        // Criação da tabela Tasks
        await db.execute('''
        CREATE TABLE Tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT,
          date TEXT NOT NULL,
          category TEXT NOT NULL DEFAULT 'Outros'
        )
        ''');
      },
    );
  }

  // Verifica se o email já está registrado
  Future<bool> isEmailExist(String email) async {
    final db = await database;
    final result = await db.query(
      'Users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  // Adiciona o usuário no banco
  Future<int> addUser(User user) async {
    final emailExists = await isEmailExist(user.email);

    if (emailExists) {
      throw Exception('Este e-mail já está cadastrado!');
    }

    final db = await database;
    return await db.insert('Users', user.toMap());
  }

  // Busca todos os usuários
  Future<List<User>> getUsers() async {
    final db = await database;
    final result = await db.query('Users');
    return result.map((map) => User.fromMap(map)).toList();
  }

  // Busca todas as tarefas
  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query(
      'Tasks',
      orderBy: 'date DESC', // Ordena as tarefas por data em ordem DESC
    );
    return result.map((map) => Task.fromMap(map)).toList();
  }

  // Adiciona uma nova tarefa
  Future<int> addTask(Task task) async {
    final db = await database;
    return await db.insert('Tasks', task.toMap());
  }

  // Atualiza uma tarefa existente
  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'Tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  // Deleta a task pelo ID
  Future<int> deleteTask(int taskId) async {
    final db = await database;
    return await db.delete(
      'Tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
