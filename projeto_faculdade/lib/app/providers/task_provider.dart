import 'package:flutter/material.dart';
import '../repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();

  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  List<Task> _filteredTasksByName = [];
  List<Task> _filteredTasksByCategory = [];
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();

  // Categorias mapeadas para cores
  final List<Map<String, dynamic>> _categories = [
    {'label': 'Trabalho', 'color': Colors.blue},
    {'label': 'Estudo', 'color': Colors.green},
    {'label': 'Lazer', 'color': Colors.orange},
    {'label': 'Rotina', 'color': Colors.red},
    {'label': 'Outros', 'color': Colors.grey},
  ];

  // Getters
  List<Task> get tasks => _tasks;
  List<Task> get filteredTasks => _filteredTasks;
  List<Task> get filteredTasksByName => _filteredTasksByName;
  List<Task> get filteredTasksByCategory => _filteredTasksByCategory;
  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  List<Map<String, dynamic>> get categories => _categories;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Obter a cor de uma categoria
  Color getCategoryColor(String categoryLabel) {
    final category = _categories.firstWhere(
      (cat) => cat['label'] == categoryLabel,
      orElse: () => {'color': Colors.grey}, // Cor padrão
    );
    return category['color'] as Color;
  }

  // Filtrar tarefas por categoria
  void filterTasksByCategory(String category) {
    _filteredTasksByCategory = _tasks.where((task) => task.category == category).toList();
    notifyListeners();
  }

  // Carregar tarefas do banco de dados
  Future<void> loadTasks({bool filterByDate = false}) async {
    _setLoading(true);
    try {
      _tasks = await _repository.getTasks();

      if (filterByDate) {
        _filteredTasks = _tasks.where((task) {
          return task.date.year == _selectedDate.year && task.date.month == _selectedDate.month && task.date.day == _selectedDate.day;
        }).toList();
      } else {
        _filteredTasks = List.from(_tasks);
      }

      _filteredTasksByName = List.from(_tasks);
      _filteredTasksByCategory = List.from(_tasks);
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Filtrar tarefas pelo título
  void filterTasks(String query) {
    _filteredTasksByName = _tasks.where((task) {
      final taskTitle = task.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return taskTitle.contains(searchLower);
    }).toList();
    notifyListeners();
  }

  // Adicionar uma nova tarefa
  Future<void> addTask(Task newTask) async {
    _setLoading(true);
    try {
      await _repository.addTask(newTask);
      await loadTasks();
    } finally {
      _setLoading(false);
    }
  }

  // Atualizar uma tarefa existente
  Future<void> updateTask(Task updatedTask) async {
    _setLoading(true);
    try {
      await _repository.updateTask(updatedTask);
      await loadTasks();
    } finally {
      _setLoading(false);
    }
  }

  // Deleta a task pelo ID
  Future<void> deleteTask(int taskId) async {
    _setLoading(true);
    try {
      await _repository.deleteTask(taskId);
      await loadTasks();
    } finally {
      _setLoading(false);
    }
  }

  // Selecionar uma data para filtragem
  void selectDate(DateTime date) {
    _selectedDate = date;
    loadTasks(filterByDate: true);
  }
}
