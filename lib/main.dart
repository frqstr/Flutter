import 'package:flutter/material.dart';
import 'screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Construction Management',
      theme: ThemeData(
        primaryColor: Colors.yellow[700], // Concrete-like grey
        scaffoldBackgroundColor: Colors.grey[100], // Light background
        appBarTheme: AppBarTheme(
          color: Colors.yellow[700],
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black, fontSize: 16),
          bodyText2: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.yellow[700], // Button color
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.yellow[700],
          foregroundColor: Colors.black,
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[600]),
      ),
      home: const WelcomeScreen(),
    );
  }
}

