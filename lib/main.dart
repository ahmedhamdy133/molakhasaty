import 'package:flutter/material.dart';
import 'package:flutter_application_4/screen/splash/splash_screen.dart';

import 'core/theme/app_theme.dart';


void main() {
  runApp(const MolakhasatyApp());
}

class MolakhasatyApp extends StatelessWidget {
  const MolakhasatyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Molakhasaty',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}