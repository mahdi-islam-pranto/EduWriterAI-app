import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app_theme/colors.dart';
import 'screens/main_navigation.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // define appbar colors
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.transparent),
        ),
        // define scaffold colors
        scaffoldBackgroundColor: AppColors.background,
      ),
      title: 'Edu Writer AI',
      home: const MainNavigation(),
    );
  }
}
