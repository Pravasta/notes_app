import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/routes/navigation.dart';
import 'package:notes_app/firebase_options.dart';

import 'core/injection/env.dart';
import 'core/theme/app_theme.dart';
import 'feature/splash/view/splash_page.dart';

// shortcut for app theme
TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;

// Set your environment here
const Environment env = Environment.development;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      navigatorKey: navigatorKey,
      home: SplashPage(),
    );
  }
}
