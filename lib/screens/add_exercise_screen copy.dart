import 'package:flutter/material.dart';



/// add_exercise_screen.dart second 1st draft


class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});
  // const AddExerciseScreen(Key? key) : super(key: key);
  // const AddExerciseScreen(); ---- super.key required here (wger) --- super(key: key) (excer)

  static const routeName = '/exercises/add';

  // ignore: constant_identifier_names
  static const STEPS_IN_FORM = 6;

  // sn=
  // ignore: constant_identifier_names
  static const appLocalizations_previous = 'Previous';

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  int _currentStep = 0;
  int lastStepIndex = AddExerciseScreen.STEPS_IN_FORM - 1;
  bool _isLoading = false;
  Widget errorWidget = const SizedBox.shrink();

  final List<GlobalKey<FormState>> _keys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  Widget _controlsBuilder(BuildContext contxt, ControlsDetails details) {
    return Column(
      children: [
        const SizedBox(height: 10),
        if (_currentStep == lastStepIndex) errorWidget,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: details.onStepCancel,
              child: Text(AddExerciseScreen.appLocalizations_previous),
            ),

            // Submit button on last step
            if (_currentStep == lastStepIndex)
              ElevatedButton(onPressed: () {}, child: Text('Save'))
            else
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: Text('Next'),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        controlsBuilder: _controlsBuilder,

        steps: [
          Step(
            title: Text('step-1'),
            content: StepBasics(stepNo: '1'),
          ),
          Step(
            title: Text('step-2'),
            content: StepBasics(stepNo: '1'),
          ),
          Step(
            title: Text('step-3'),
            content: StepBasics(stepNo: '1'),
          ),
          Step(
            title: Text('step-4'),
            content: StepBasics(stepNo: '1'),
          ),
          Step(
            title: Text('step-5'),
            content: StepBasics(stepNo: '1'),
          ),
          Step(
            title: Text('step-6'),
            content: StepBasics(stepNo: '1'),
          ),
        ],
      ),

      // body: Center(child: Container(
      //   color: Colors.red,
      //   child: Text(
      //     'add exercise'
      //   ),
      // ),),
    );
  }
}

class StepBasics extends StatelessWidget {
  final String stepNo;
  const StepBasics({super.key, required this.stepNo});

  @override
  Widget build(BuildContext context) {
    // return const Text('data', key: ValueKey(stepNo),);
    return const Text('data', key: ValueKey(1));
  }
}

// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\screens\add_exercise_screen.dart
