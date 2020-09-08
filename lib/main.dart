import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medium_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.abhayaLibreTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}
