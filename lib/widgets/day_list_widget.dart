import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/days_provider.dart';
import '../screens/day_detail_screen.dart';
import '../screens/gym_mode_screen.dart';

class DayListWidget extends StatelessWidget {
  final int? limit;

  const DayListWidget({Key? key, this.limit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DaysProvider>(
      builder: (context, daysProvider, child) {
        if (daysProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final days = limit != null
            ? daysProvider.days.take(limit!).toList()
            : daysProvider.days;

        if (days.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No workouts found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8, //
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: day.isRest
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  child: Icon(
                    day.isRest ? Icons.hotel : Icons.fitness_center,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  day.isRest ? 'Rest Day' : 'Training Day',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, //
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Day ${day.order} • ${day.typeOf}'),
                    if (!day.isRest && day.slots.isNotEmpty)
                      Text(
                        '${day.slots.length} slot(s), '
                        '${day.slots.fold(0, (sum, slot) => sum + slot.entries.length)} exercises',
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                ),
                trailing: day.isRest
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.play_arrow),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(GymModeScreen.routeName, arguments: day);
                        },
                      ),
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(DayDetailScreen.routeName, arguments: day.id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
