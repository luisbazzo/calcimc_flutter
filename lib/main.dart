import 'package:flutter/material.dart';
import 'package:flutter_calcimc_prova2/views/login_screen.dart';

void main() 
{
  runApp(const CalcIMCApp());
}

class CalcIMCApp extends StatelessWidget 
{
  const CalcIMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}