import 'package:flutter/material.dart';
import '../../models/entry.dart';

class ExercisePage extends StatefulWidget {
  final PageController controller;
  final Entry entry;
  final String slotComment;
  final int currentExercise;
  final int totalExercises;

  const ExercisePage({
    Key? key,
    required this.controller,
    required this.entry,
    required this.slotComment,
    required this.currentExercise,
    required this.totalExercises,
  }) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final List<bool> _completedSets = [];
  final List<TextEditingController> _weightControllers = [];
  final List<TextEditingController> _repsControllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.entry.sets; i++) {
      _completedSets.add(false);
      _weightControllers.add(TextEditingController());
      _repsControllers.add(TextEditingController(text: widget.entry.reps.toString()));
    }
  }

  @override
  void dispose() {
    for (var controller in _weightControllers) {
      controller.dispose();
    }
    for (var controller in _repsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleSet(int index) {
    setState(() {
      _completedSets[index] = !_completedSets[index];
    });
  }

  bool get _allSetsCompleted => _completedSets.every((completed) => completed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => widget.controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              ),
              Expanded(
                child: Text(
                  'Exercise ${widget.currentExercise} of ${widget.totalExercises}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 24),

          // Exercise info
          Card(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 48,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.entry.exercise,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  if (widget.slotComment.isNotEmpty) ...[
                    const SizedBox(height: 4),  
                    Text(
                      widget.slotComment,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Sets tracking
          Expanded(
            child: ListView.builder(
              itemCount: widget.entry.sets,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Set number and checkbox
                      GestureDetector(
                        onTap: () => _toggleSet(index),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _completedSets[index]
                                ? Colors.green
                                : Colors.grey[300],
                          ),
                          child: Center(
                            child: _completedSets[index]
                                ? const Icon(Icons.check, color: Colors.white)
                                : Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Weight input
                      Expanded(
                        child: TextField(
                          controller: _weightControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Weight (kg)',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Reps input
                      Expanded(
                        child: TextField(
                          controller: _repsControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Reps',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Next button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _allSetsCompleted
                  ? () {
                      widget.controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _allSetsCompleted ? 'NEXT' : 'Complete all sets to continue',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\widgets\gym_mode\exercise_page.dart
