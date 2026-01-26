import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/days_provider.dart';
import '../providers/routine_provider.dart';
import '../widgets/day_list_widget.dart';
import '../widgets/routine_overview_widget.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final daysProvider = Provider.of<DaysProvider>(context, listen: false);
    final routineProvider = Provider.of<RoutineProvider>(context, listen: false);
    
    await daysProvider.fetchDays();
    await routineProvider.fetchRoutine(1); // Load default routine
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const DashboardTab(),
      const WorkoutsTab(),
      const RoutinesTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('EXCER'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Routines',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Provider.of<DaysProvider>(context, listen: false).fetchDays();
        await Provider.of<RoutineProvider>(context, listen: false).fetchRoutine(1);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          RoutineOverviewWidget(),
          SizedBox(height: 16),
          Text(
            'Today\'s Workout',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          DayListWidget(limit: 5),
        ],
      ),
    );
  }
}

class WorkoutsTab extends StatelessWidget {
  const WorkoutsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<DaysProvider>(context, listen: false).fetchDays(),
      child: const DayListWidget(),
    );
  }
}

class RoutinesTab extends StatelessWidget {
  const RoutinesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Provider.of<RoutineProvider>(context, listen: false).fetchRoutine(1),
      child: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: RoutineOverviewWidget(expanded: true),
      ),
    );
  }
}