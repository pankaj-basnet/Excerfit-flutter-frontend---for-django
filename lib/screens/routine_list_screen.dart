import 'package:excerfit/widgets/routines/app_bar.dart';
import 'package:flutter/material.dart';

class RoutineListScreen extends StatelessWidget {
  // const RoutineListScreen({super.key});
  const RoutineListScreen({Key? key}) : super(key: key);
  // const RoutineListScreen();

  // const RoutineListScreen({super.key});  ---  // const RoutineListScreen({Key? key}) : super(key: key);  ---  // const RoutineListScreen();

  static const routeName = '/workout-plans-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RoutineListAppBar(),

    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\screens\routine_list_screen.dart
