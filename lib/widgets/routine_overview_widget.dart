import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/routine_provider.dart';


class RoutineOverviewWidget extends StatelessWidget {
  final bool expanded;

  const RoutineOverviewWidget({Key? key, this.expanded = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RoutineProvider>(
      builder: (context, routineProvider, child) {
        final routine = routineProvider.currentRoutine;

        if (routineProvider.isLoading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (routine == null) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.calendar_today, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Active Routine',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create a routine to get started',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to create routine screen
                    },
                    child: const Text('Create Routine'),
                  ),
                ],
              ),
            ),
          );
        }

        final dateFormat = DateFormat.yMd();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Routine',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${dateFormat.format(routine.start)} - ${dateFormat.format(routine.end)}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (expanded) ...[
                  const Divider(height: 32),
                  Text(
                    'Related Routines',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ...routine.relatedRoutines.map((relatedRoutine) => ListTile(
                        leading: const Icon(Icons.schedule),
                        title: Text(relatedRoutine.name),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                      )),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\widgets\routine_overview_widget.dart
