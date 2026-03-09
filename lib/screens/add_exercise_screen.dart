import 'package:flutter/material.dart';

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen(Key? key) : super(key: key);
  // const AddExerciseScreen(); ---- super.key required here (wger) --- super(key: key) (excer)

  static const routeName = '/exercises/add';

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
