import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../providers/task_provider.dart';
import '../../shared/add_new_task_modal.dart';
import '../../shared/bottom_nav_bar.dart';
import 'widgets/selected_date_header_widget.dart';
import 'widgets/task_list_calendar_page_widget.dart';
import 'widgets/week_days_header_widget.dart';

class CalendarPage extends StatelessWidget {
  final User user;

  const CalendarPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final weekDays = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskProvider.loadTasks(filterByDate: true);
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SelectedDateHeader(selectedDate: taskProvider.selectedDate),
          WeekDaysHeader(weekDays: weekDays),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, _) {
                return TaskListCalendarPageWidget(
                  tasks: provider.filteredTasks,
                  isLoading: provider.isLoading,
                );
              },
            ),
          ),
        ],
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
                    await taskProvider.addTask(newTask);
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
        user: user,
      ),
    );
  }
}
