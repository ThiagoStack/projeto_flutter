import '../database/local_database.dart';
import '../models/user_model.dart';

class UserRepository {
  final LocalDatabase _dbHelper = LocalDatabase();

  // Adicionar um novo usuário
  Future<void> addUser(User user) async {
    // print('Nome: ${user.name}');
    // print('Email: ${user.email}');
    // print('Senha: ${user.password}');
    await _dbHelper.addUser(user);
  }
  // Obter todos os usuários do banco de dados
  Future<List<User>> getUsers() async {
    return await _dbHelper.getUsers();
  }

  // Verificar se o email já está registrado
  Future<bool> isEmailRegistered(String email) async {
    final users = await getUsers();
    return users.any((user) => user.email == email);
  }

  // Autenticar usuário por email e senha
  Future<User?> authenticateUser(String email, String senha) async {
    final users = await getUsers();
    try {
      return users.firstWhere(
        (user) => user.email == email && user.password == senha,
      );
    } catch (e) {
      return null; 
    }
  }

  
}
