import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_faculdade/app/pages/calendar_page/calendar_page.dart';

import '../../models/user_model.dart';
import '../../providers/task_provider.dart';
import '../../shared/add_new_task_modal.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../shared/category_filter_widget.dart';
import 'widgets/task_list_home_widget.dart';
import 'widgets/user_header_home_page.dart';
import 'task_detail_page.dart';

class HomePage extends StatefulWidget {
  final User? user;

  const HomePage({super.key, this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = context.read<TaskProvider>();
      taskProvider.loadTasks(filterByDate: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHeaderHomePage(
              userName: widget.user!.name,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.03),
            TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<TaskProvider>().filterTasks(query);
              },
              decoration: InputDecoration(
                labelText: 'Buscar Task',
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Center(
              child: CategoryFilterWidget(
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });

                  // Chamar o filtro de categorias no TaskProvider
                  if (category != null) {
                    context.read<TaskProvider>().filterTasksByCategory(category);
                  } else {
                    // Recarregar todas as tarefas caso nenhuma categoria esteja selecionada
                    context.read<TaskProvider>().loadTasks(filterByDate: false);
                  }
                },
              ),
            ),

            // Exibe a lista de tarefas filtradas
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, _) {
                  if (taskProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Determina a lista correta de tarefas para exibir
                  final tasksToShow = _searchController.text.isNotEmpty
                      ? taskProvider.filteredTasksByName
                      : (_selectedCategory != null ? taskProvider.filteredTasksByCategory : taskProvider.tasks);

                  return TaskListHomeWidget(
                    tasks: tasksToShow, 
                    onTaskTapped: (task) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(
                            task: task,
                            onTaskUpdated: (updatedTask) async {
                              await context.read<TaskProvider>().updateTask(updatedTask);
                            },
                          ),
                        ),
                      );
                    },
                    onCalendarTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarPage(user: widget.user!),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: AddTaskModal(
                  onTaskAdded: (newTask) async {
                    await context.read<TaskProvider>().addTask(newTask); 
                  },
                ),
              );
            },
          );
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        onItemTapped: (index) {},
        selectedIndex: 0,
        user: widget.user!,
      ),
    );
  }
}
