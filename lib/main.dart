import 'package:dr_als_parenting_tips_and_tools_flutter/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parenting Tips & Tools',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(surface: Colors.blueGrey)
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Parenting Tips & Tools"),
        ),
        body: const MainScreen(),
      ),
    );
  }
}
