import 'package:flutter/material.dart';

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

  // GENERATING 6 GLOBAL KEYS (1 for each form)
  final List<GlobalKey<FormState>> _keys =
      List.generate(AddExerciseScreen.STEPS_IN_FORM, (_) => GlobalKey<FormState>());

  /// NEXT STEP
  void _onStepContinue() {
    // Validate the current step's form using its specific GlobalKey
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

    // Iterate through ALL forms to ensure no errors were missed
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
      errorWidget = const SizedBox.shrink(); // Clear errors
    });

    /// Simulate API request
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
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
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
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

  /// COMPLETED: Explicitly building 6 steps using the intern's individual classes
  List<Step> _buildSteps() {
    return [
      Step(
        title: const Text('Step 1'),
        content: Form(
          key: _keys[0], // 0-indexed key for Step 1
          child: const StepBasics1(stepNo: '1'),
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Step 2'),
        content: Form(
          key: _keys[1], // 1-indexed key for Step 2
          child: const StepBasics2(stepNo: '2'),
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Step 3'),
        content: Form(
          key: _keys[2],
          child: const StepBasics3(stepNo: '3'),
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Step 4'),
        content: Form(
          key: _keys[3],
          child: const StepBasics4(stepNo: '4'),
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: const Text('Step 5'),
        content: Form(
          key: _keys[4],
          child: const StepBasics5(stepNo: '5'),
        ),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: const Text('Step 6'),
        content: Form(
          key: _keys[5],
          child: const StepBasics6(stepNo: '6'),
        ),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exercise'),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        controlsBuilder: _controlsBuilder,
        steps: _buildSteps(),
      ),
    );
  }
}

// --- INTERN'S INDIVIDUAL STEP WIDGETS ---

class StepBasics1 extends StatelessWidget {
  final String stepNo;
  const StepBasics1({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}

class StepBasics2 extends StatelessWidget {
  final String stepNo;
  const StepBasics2({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}

class StepBasics3 extends StatelessWidget {
  final String stepNo;
  const StepBasics3({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}

class StepBasics4 extends StatelessWidget {
  final String stepNo;
  const StepBasics4({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}

class StepBasics5 extends StatelessWidget {
  final String stepNo;
  const StepBasics5({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}

class StepBasics6 extends StatelessWidget {
  final String stepNo;
  const StepBasics6({super.key, required this.stepNo});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: ValueKey(stepNo),
      decoration: InputDecoration(labelText: 'Input for Step $stepNo'),
      validator: (value) => (value == null || value.isEmpty) ? 'Please enter value for step $stepNo' : null,
    );
  }
}


// D:\src_dev\flutter\EXCER-DJANGO-FLUTTER-PROVIDER-\2026-\SRC-\CODE-\excerfit\lib\screens\add_exercise_screen.dart
