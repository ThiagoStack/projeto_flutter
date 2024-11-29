import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDateHeader extends StatelessWidget {
  final DateTime selectedDate;

  const SelectedDateHeader({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 90, bottom: 30),
      child: Column(
        children: [
          Text(
            DateFormat('EEEE', 'pt_BR').format(selectedDate).replaceFirst(
                  DateFormat('EEEE', 'pt_BR').format(selectedDate)[0],
                  DateFormat('EEEE', 'pt_BR').format(selectedDate)[0].toUpperCase(),
                ),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd MMMM yyyy', 'pt_BR').format(selectedDate),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
