import 'package:expenses/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Expenses());
}

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 25,
            fontFamily: 'OpenSans'
          ),
        ),
      ),
    );
  }
}
