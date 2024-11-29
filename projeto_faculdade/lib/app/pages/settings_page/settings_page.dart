import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../providers/task_provider.dart';
import '../../shared/add_new_task_modal.dart';
import '../../shared/bottom_nav_bar.dart';
import '../home_page/home_page.dart';

class SettingsPage extends StatelessWidget {
  final User user;

  const SettingsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.08,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título "Configurações"
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(user: user),
                      ),
                    );
                  },
                ),
                Text(
                  'Configurações',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            // Opções de configurações
            ListTile(
              title: const Text('Sincronização e conta'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.sync, color: Colors.white),
            ),
            ListTile(
              title: const Text('Notificação'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.notifications, color: Colors.white),
            ),
            ListTile(
              title: const Text('Comentários'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.feedback, color: Colors.white),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.person, color: Colors.white),
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.logout, color: Colors.white),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Informações na parte inferior
            Text(
              'Informação',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ListTile(
              title: const Text('Política de Privacidade'),
              onTap: () {},
              textColor: Colors.white,
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
            ),
            Text(
              'Versão: 1.0',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: screenWidth * 0.04,
              ),
            ),
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
