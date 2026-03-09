import 'package:excerfit/screens/add_exercise_screen.dart';
import 'package:flutter/material.dart';

enum _RoutineAppBarOptions { list, contribute }

class RoutineListAppBar extends StatelessWidget implements PreferredSizeWidget {
  // const RoutineListAppBar({super.key});
  const RoutineListAppBar();

  // ignore: constant_identifier_names
  static const i18n_routines = 'Routines';

  // ignore: constant_identifier_names
  static const i18n_exerciseList = 'Exercise list';

  // ignore: constant_identifier_names
  static const i18n_contributeExercise = 'Contribute an exercise';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(RoutineListAppBar.i18n_routines),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem<_RoutineAppBarOptions>(
                value: _RoutineAppBarOptions.list,
                child: Text(RoutineListAppBar.i18n_exerciseList),
              ),
              PopupMenuItem<_RoutineAppBarOptions>(
                value: _RoutineAppBarOptions.contribute,
                child: Text(RoutineListAppBar.i18n_contributeExercise),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case _RoutineAppBarOptions.contribute:
                Navigator.of(context).pushNamed(AddExerciseScreen.routeName);
                break;
              case _RoutineAppBarOptions.list:
                Navigator.of(context).pushNamed(AddExerciseScreen.routeName);
                break;
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\widgets\routines\app_bar.dart
