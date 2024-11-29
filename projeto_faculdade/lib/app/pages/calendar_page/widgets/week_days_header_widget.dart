import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/task_provider.dart';

class WeekDaysHeader extends StatelessWidget {
  final List<DateTime> weekDays;

  const WeekDaysHeader({
    super.key,
    required this.weekDays,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Container(
      height: 100,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weekDays.length,
          itemBuilder: (context, index) {
            final day = weekDays[index];
            final isSelected = day.day == taskProvider.selectedDate.day &&
                day.month == taskProvider.selectedDate.month &&
                day.year == taskProvider.selectedDate.year;

            return GestureDetector(
              onTap: () => taskProvider.selectDate(day),
              child: Container(
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color.fromARGB(255, 233, 133, 46) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEE', 'pt_BR').format(day),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('dd').format(day),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.purple,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
