class AppConstants {
  // App Info
  static const String appName = 'Study Planner';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String themeKey = 'isDarkMode';
  static const String userKey = 'user_data';
  static const String timetableKey = 'timetable_data';
  static const String assignmentsKey = 'assignments_data';
  static const String examsKey = 'exams_data';
  static const String topicsKey = 'topics_data';
  static const String todosKey = 'todos_data';

  // Pomodoro Timer
  static const int defaultWorkDuration = 25; // minutes
  static const int defaultShortBreakDuration = 5; // minutes
  static const int defaultLongBreakDuration = 15; // minutes
  static const int defaultLongBreakInterval = 4; // work sessions

  // Notification IDs
  static const int pomodoroNotificationId = 1;
  static const int assignmentNotificationId = 2;
  static const int examNotificationId = 3;
  static const int revisionNotificationId = 4;

  // Routes
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String timetableRoute = '/timetable';
  static const String assignmentsRoute = '/assignments';
  static const String examsRoute = '/exams';
  static const String topicsRoute = '/topics';
  static const String todosRoute = '/todos';
  static const String pomodoroRoute = '/pomodoro';
  static const String settingsRoute = '/settings';
}
