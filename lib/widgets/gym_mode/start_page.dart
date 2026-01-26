import 'package:flutter/material.dart';
import '../../models/day.dart';

class StartPage extends StatelessWidget {
  final PageController controller;
  final Day day;
  final VoidCallback onStart;

  const StartPage({
    Key? key,
    required this.controller,
    required this.day,
    required this.onStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalExercises = day.slots.fold(
      0,
      (sum, slot) => sum + slot.entries.length,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: Text(
                    'Today\'s Workout',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // Balance the close button
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Workout info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Day ${day.order}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    day.typeOf,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$totalExercises exercises',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Exercise list
          Expanded(
            child: ListView(
              children: [
                Text(
                  'Exercises',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                ...day.slots.expand((slot) => slot.entries.map((entry) => Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.fitness_center),
                        ),
                        title: Text(entry.exercise),
                        subtitle: Text(slot.comment),
                        trailing: Text(
                          '${entry.sets} × ${entry.reps}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ))),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Start button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                onStart();
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'START WORKOUT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}