import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:excerfit/services/api_client.dart';
import 'package:excerfit/providers/auth_provider.dart';
import 'package:excerfit/providers/days_provider.dart';
import 'package:excerfit/providers/routine_provider.dart';
import 'package:excerfit/screens/login_screen.dart';
import 'package:excerfit/screens/home_screen.dart';
import 'package:excerfit/screens/day_detail_screen.dart';
import 'package:excerfit/screens/gym_mode_screen.dart';

void main() {
  _setupLogging();
  runApp(const ExcerApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time} [${record.loggerName}] ${record.message}');
  });
}

class ExcerApp extends StatelessWidget {
  const ExcerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient();

    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: apiClient),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(apiClient),
        ),
        ChangeNotifierProxyProvider<AuthProvider, DaysProvider>(
          create: (_) => DaysProvider(apiClient),
          update: (_, auth, previous) => previous ?? DaysProvider(apiClient),
        ),
        ChangeNotifierProxyProvider<AuthProvider, RoutineProvider>(
          create: (_) => RoutineProvider(apiClient),
          update: (_, auth, previous) => previous ?? RoutineProvider(apiClient),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'EXCER - Exercise Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
            // cardTheme: CardTheme(
            //   elevation: 2,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            // ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          home: FutureBuilder<bool>(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              return auth.isAuthenticated
                  ? const HomeScreen()
                  : const LoginScreen();
            },
          ),
          routes: {
            LoginScreen.routeName: (_) => const LoginScreen(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            DayDetailScreen.routeName: (_) => const DayDetailScreen(),
            GymModeScreen.routeName: (_) => const GymModeScreen(),
          },
        ),
      ),
    );
  }
}