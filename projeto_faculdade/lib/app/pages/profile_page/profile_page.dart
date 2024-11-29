import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_model.dart';
import '../../providers/task_provider.dart';
import '../../shared/add_new_task_modal.dart';
import '../../shared/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

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
            // Título "Perfil"
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Campo Nome
            TextFormField(
              initialValue: user.name,
              decoration: _buildInputDecoration('Nome'),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {},
            ),
            SizedBox(height: screenHeight * 0.02),

            // Campo Email
            TextFormField(
              initialValue: user.email,
              decoration: _buildInputDecoration('E-mail'),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
            ),
            SizedBox(height: screenHeight * 0.02),

            // Campo Senha
            TextFormField(
              obscureText: true,
              initialValue: '*  *  *  *  * ',
              decoration: _buildInputDecoration('Senha'),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {},
            ),
            SizedBox(height: screenHeight * 0.05),

            // Botão de salvar alterações
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Alterações salvas com sucesso!')),
                  );
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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

  // Método para construir a decoração dos campos de texto
  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
      ),
    );
  }
}
