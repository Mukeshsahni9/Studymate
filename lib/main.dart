import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/exams/exams_bloc.dart';
import 'blocs/exams/exams_event.dart';
import 'blocs/timetable/timetable_bloc.dart';
import 'blocs/timetable/timetable_event.dart';
import 'blocs/pomodoro/pomodoro_bloc.dart';
import 'blocs/pomodoro/pomodoro_event.dart';
import 'blocs/progress/progress_bloc.dart';
import 'blocs/progress/progress_event.dart';
import 'screens/dashboard_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProgressBloc(prefs: prefs)..add(LoadProgress()),
        ),
        BlocProvider(
          create: (context) => ExamsBloc(
            prefs,
            progressBloc: context.read<ProgressBloc>(),
          )..add(LoadExams()),
        ),
        BlocProvider(
          create: (context) => TimetableBloc(prefs)..add(LoadTimetable()),
        ),
        BlocProvider(
          create: (context) => PomodoroBloc(
            prefs,
            progressBloc: context.read<ProgressBloc>(),
          )..add(LoadPomodoroSettings()),
        ),
      ],
      child: MaterialApp(
        title: 'StudyMate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primaryColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppTheme.primaryColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        home: const DashboardScreen(),
      ),
    );
  }
}
