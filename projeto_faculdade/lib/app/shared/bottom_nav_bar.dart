import 'package:flutter/material.dart';
import 'package:projeto_faculdade/app/pages/home_page/home_page.dart';
import 'package:projeto_faculdade/app/pages/profile_page/profile_page.dart';
import 'package:projeto_faculdade/app/pages/settings_page/settings_page.dart';

import '../models/user_model.dart';
import '../pages/calendar_page/calendar_page.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  final User user;

  const BottomNavBar({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              color: Colors.purple,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(user: user),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Colors.purple),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarPage(user: user),
              ),
            ),
          ),
          const SizedBox(width: 48),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.purple),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(user: user),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.purple),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>  SettingsPage(user: user),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
