import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task_model.dart';
import '../../../providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskListHomeWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskTapped;
  final VoidCallback onCalendarTapped;

  const TaskListHomeWidget({
    super.key,
    required this.tasks,
    required this.onTaskTapped,
    required this.onCalendarTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final taskProvider = Provider.of<TaskProvider>(context);

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final categoryColor = taskProvider.getCategoryColor(task.category);

        return Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.purple[100],
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(screenWidth * 0.03),
              title: Row(
                children: [
                  Container(
                    width: screenWidth * 0.03,
                    height: screenWidth * 0.03,
                    decoration: BoxDecoration(
                      color: categoryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.009),
                  Text(
                    task.description.isNotEmpty ? task.description : '',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(task.date)} - ${DateFormat('HH:mm').format(task.date)}',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: screenWidth * 0.030,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
                onPressed: () async {
                  // Show a confirmation dialog
                  bool? shouldDelete = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar Exclusão'),
                        content: const Text('Tem certeza de que deseja excluir esta tarefa?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Excluir'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldDelete == true) {
                    await context.read<TaskProvider>().deleteTask(task.id!);
                  }
                },
              ),
              onTap: () => onTaskTapped(task),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
