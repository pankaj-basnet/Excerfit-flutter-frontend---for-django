import 'package:flutter/material.dart';
import '../../models/day.dart';
import 'start_page.dart';
import 'exercise_page.dart';
import 'rest_page.dart';
import 'session_page.dart';

class GymModeWidget extends StatefulWidget {
  final Day day;

  const GymModeWidget({Key? key, required this.day}) : super(key: key);

  @override
  State<GymModeWidget> createState() => _GymModeWidgetState();
}

class _GymModeWidgetState extends State<GymModeWidget> {
  late PageController _controller;
  int _currentPage = 0;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startTime = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildPages() {
    final List<Widget> pages = [];

    // Start page
    pages.add(StartPage(
      controller: _controller,
      day: widget.day,
      onStart: () {
        setState(() => _startTime = DateTime.now());
      },
    ));

    // Exercise pages
    for (final slot in widget.day.slots) {
      for (final entry in slot.entries) {
        pages.add(ExercisePage(
          controller: _controller,
          entry: entry,
          slotComment: slot.comment,
          currentExercise: slot.entries.indexOf(entry) + 1,
          totalExercises: slot.entries.length,
        ));

        // Add rest page after each exercise (except the last one)
        if (entry != slot.entries.last || slot != widget.day.slots.last) {
          pages.add(RestPage(
            controller: _controller,
            restDuration: const Duration(seconds: 90),
          ));
        }
      }
    }

    // Session summary page
    pages.add(SessionPage(
      controller: _controller,
      day: widget.day,
      startTime: _startTime,
    ));

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress indicator
        LinearProgressIndicator(
          value: _currentPage / (_buildPages().length - 1),
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: _buildPages(),
          ),
        ),
      ],
    );
  }
}