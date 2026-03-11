import 'package:flutter/material.dart';

/// add_exercise_screen.dart second 2nd draft

class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  static const routeName = '/exercises/add';

  static const int STEPS_IN_FORM = 6;

  static const String appLocalizations_previous = 'Previous';

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  int _currentStep = 0;

  bool _isLoading = false;

  Widget errorWidget = const SizedBox.shrink();

  int get lastStepIndex => AddExerciseScreen.STEPS_IN_FORM - 1;

  final List<GlobalKey<FormState>> _keys =
      List.generate(AddExerciseScreen.STEPS_IN_FORM, (_) => GlobalKey<FormState>());

  /// NEXT STEP
  void _onStepContinue() {
    final isValid = _keys[_currentStep].currentState?.validate() ?? true;

    if (!isValid) return;

    if (_currentStep < lastStepIndex) {
      setState(() {
        _currentStep++;
      });
    }
  }

  /// PREVIOUS STEP
  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  /// FINAL SAVE
  void _submitForm() {
    bool allValid = true;

    for (var key in _keys) {
      if (!(key.currentState?.validate() ?? true)) {
        allValid = false;
      }
    }

    if (!allValid) {
      setState(() {
        errorWidget = const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Please fix errors before saving',
            style: TextStyle(color: Colors.red),
          ),
        );
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    /// Simulate API request
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    });
  }

  /// CUSTOM STEPPER BUTTONS
  Widget _controlsBuilder(BuildContext context, ControlsDetails details) {
    return Column(
      children: [
        const SizedBox(height: 10),

        if (_currentStep == lastStepIndex) errorWidget,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// PREVIOUS BUTTON
            OutlinedButton(
              onPressed: _currentStep == 0 ? null : details.onStepCancel,
              child: const Text(AddExerciseScreen.appLocalizations_previous),
            ),

            /// LAST STEP → SAVE
            if (_currentStep == lastStepIndex)
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Save'),
              )

            /// OTHERWISE → NEXT
            else
              ElevatedButton(
                onPressed: details.onStepContinue,
                child: const Text('Next'),
              ),
          ],
        ),
      ],
    );
  }

  List<Step> _buildSteps() {
    return List.generate(AddExerciseScreen.STEPS_IN_FORM, (index) {
      return Step(
        title: Text('Step ${index + 1}'),
        content: Form(
          key: _keys[index],
          child: StepBasics(stepNo: '${index + 1}'),
        ),
        isActive: _currentStep >= index,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: _controlsBuilder,
        steps: _buildSteps(),
      ),
    );
  }
}

class StepBasics extends StatelessWidget {
  final String stepNo;

  const StepBasics({super.key, required this.stepNo});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(stepNo),
      decoration: InputDecoration(
        labelText: 'Input for Step $stepNo',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter value for step $stepNo';
        }
        return null;
      },
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\screens\add_exercise_screen.dart
