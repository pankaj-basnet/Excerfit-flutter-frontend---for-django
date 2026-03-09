import 'package:flutter/material.dart';
import '../models/day.dart';
import '../widgets/gym_mode/gym_mode_widget.dart';

class GymModeScreen extends StatelessWidget {
  static const routeName = '/gym-mode';

  const GymModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final day = ModalRoute.of(context)!.settings.arguments as Day;

    return Scaffold(
      body: SafeArea(
        child: GymModeWidget(day: day),
      ),
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\screens\gym_mode_screen.dart
