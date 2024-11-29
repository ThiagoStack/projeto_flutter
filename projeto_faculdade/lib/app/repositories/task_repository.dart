import '../database/local_database.dart';
import '../models/task_model.dart';

class TaskRepository {
  final LocalDatabase _dbHelper = LocalDatabase();

  // Adicionar uma nova tarefa
  Future<void> addTask(Task task) async {
    await _dbHelper.addTask(task);
  }

  // Obter todas as tarefas do banco de dados
  Future<List<Task>> getTasks() async {
    return await _dbHelper.getTasks();
  }

  // Atualizar uma tarefa existente
  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
  }

  // Deletar uma tarefa
  Future<void> deleteTask(int taskId) async {
    await _dbHelper.deleteTask(taskId);
  }
}
