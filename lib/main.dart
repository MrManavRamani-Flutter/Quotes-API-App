import 'package:flutter/material.dart';
import 'package:quotes_api_app/theme.dart';
import 'package:quotes_api_app/view/home/home_screen.dart';
import 'package:quotes_api_app/view/intro/intro_screen.dart';
import 'package:quotes_api_app/view/liked_quotes/liked_quotes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      initialRoute: 'welcome',
      routes: {
        '/': (context) => const HomePage(),
        'welcome': (context) => const IntroScreen(),
        'like_screen': (context) => const FavoriteScreen(),
      },
    );
  }
}
