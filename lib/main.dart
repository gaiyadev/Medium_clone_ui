import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medium_app/screens/home_page_screen.dart';
import 'package:medium_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _page = MyHomePage();
  final _storage = new FlutterSecureStorage();

  void _checkAuthStatus() async {
    String token = await _storage.read(key: 'token');
    if (token != null) {
      setState(() {
        _page = HomePageScreen();
      });
    } else {
      setState(() {
        _page = MyHomePage();
      });
    }
  }

  @override
  void initState() {
    _checkAuthStatus();
    super.initState();
  }

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
      home: _page,
    );
  }
}
