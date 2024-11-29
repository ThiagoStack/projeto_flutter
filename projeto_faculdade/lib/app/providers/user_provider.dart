import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repository = UserRepository();

  // Controladores para campos de entrada
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void _validatePasswords() {
    if (passwordController.text != confirmPasswordController.text) {
      throw Exception("As senhas não coincidem!");
    }
  }

  // Adicionar um novo usuário
  Future<void> addPessoa() async {
    _validatePasswords();

    final user = User(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    // print('[PROVIDER] Dados digitados:');
    // print('Nome: ${user.name}');
    // print('Email: ${user.email}');
    // print('Senha: ${user.password}');

    try {
      _setLoading(true);

      final emailExists = await _repository.isEmailRegistered(user.email);
      if (emailExists) throw Exception("O e-mail já está registrado!");

      await _repository.addUser(user);
      await loadPessoas();
      _clearControllers();
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Fazer login
  Future<User> login(String email, String senha) async {
    _setLoading(true);
    try {
      final user = await _repository.authenticateUser(email, senha);
      if (user == null) throw Exception("Usuário ou senha incorretos!");
      return user;
    } finally {
      _setLoading(false);
    }
  }

  // Carregar usuários do banco de dados
  Future<void> loadPessoas() async {
    _users = await _repository.getUsers();
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
