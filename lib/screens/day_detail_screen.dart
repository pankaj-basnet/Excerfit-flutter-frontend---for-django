import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/day.dart';
import '../providers/days_provider.dart';
import 'gym_mode_screen.dart';

class DayDetailScreen extends StatelessWidget {
  static const routeName = '/day-detail';

  const DayDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayId = ModalRoute.of(context)!.settings.arguments as int;
    final daysProvider = Provider.of<DaysProvider>(context);
    final day = daysProvider.findById(dayId);

    if (day == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Day Details')),
        body: const Center(child: Text('Day not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(day.isRest ? 'Rest Day' : 'Training Day'),
        actions: [
          if (!day.isRest)
            IconButton(
              icon: const Icon(Icons.play_arrow),
              tooltip: 'Start Workout',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  GymModeScreen.routeName,
                  arguments: day,
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          day.isRest ? Icons.hotel : Icons.fitness_center,
                          size: 32,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Day ${day.order}',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                day.typeOf,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (!day.isRest) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Exercises',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              ...day.slots.map((slot) => Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      title: Text('Slot ${slot.order}'),
                      subtitle: Text(slot.comment),
                      children: slot.entries.map((entry) => ListTile(
                            leading: const Icon(Icons.check_circle_outline),
                            title: Text(entry.exercise),
                            trailing: Text(
                              '${entry.sets} × ${entry.reps}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )).toList(),
                    ),
                  )),
            ] else
              const Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.spa, size: 64, color: Colors.green),
                    SizedBox(height: 16),
                    Text(
                      'Rest and Recovery',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Take this day to rest and let your muscles recover.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: day.isRest
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  GymModeScreen.routeName,
                  arguments: day,
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Workout'),
            ),
    );
  }
}