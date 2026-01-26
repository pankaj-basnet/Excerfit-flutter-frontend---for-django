import 'package:flutter/material.dart';
import '../../models/day.dart';

class SessionPage extends StatefulWidget {
  final PageController controller;
  final Day day;
  final DateTime startTime;

  const SessionPage({
    Key? key,
    required this.controller,
    required this.day,
    required this.startTime,
  }) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  int _impression = 3; // 1-5 rating
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  void _saveSession() {
    // Here you would typically save the session data to your backend
    // For now, we'll just show a success message and close the gym mode
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Workout session saved!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final endTime = DateTime.now();
    final duration = endTime.difference(widget.startTime);
    final totalExercises = widget.day.slots.fold(
      0,
      (sum, slot) => sum + slot.entries.length,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Text(
            'Workout Complete!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Icon(
            Icons.celebration,
            size: 64,
            color: Colors.green,
          ),
          const SizedBox(height: 24),

          // Session summary
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Session Summary',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Divider(),
                        _buildSummaryRow('Duration', _formatDuration(duration)),
                        _buildSummaryRow('Exercises', totalExercises.toString()),
                        _buildSummaryRow(
                          'Total Sets',
                          widget.day.slots
                              .fold(0, (sum, slot) => sum + slot.entries.fold(0, (s, e) => s + e.sets))
                              .toString(),
                        ),
                        _buildSummaryRow('Day', 'Day ${widget.day.order}'),
                        _buildSummaryRow('Type', widget.day.typeOf),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Rating
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How was your workout?',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            final rating = index + 1;
                            return GestureDetector(
                              onTap: () {
                                setState(() => _impression = rating);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    _impression >= rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 40,
                                    color: _impression >= rating
                                        ? Colors.amber
                                        : Colors.grey,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _getRatingLabel(rating),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _impression >= rating
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes (optional)',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _notesController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Add any notes about this workout...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveSession,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'FINISH WORKOUT',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _getRatingLabel(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Great';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
}