import 'package:flutter/material.dart';
import 'package:medium_app/screens/auth_home_screen.dart';
import 'package:medium_app/screens/profile_screen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentState = 0;
  List<Widget> _screens= [
    AuthHomeScreen(),
    ProfileScreen(),
  ];

  List<String> _appBarTitle = [
    'Home Page',
    'Profile Page',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Username'),
                ],
              ),
            ),
            ListTile(
              title: const Text('All Post'),

            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title:Text(_appBarTitle[_currentState]),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        
        color: Colors.teal,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _currentState == 0 ?  Colors.white :  Colors.white54,
                  ),
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      _currentState = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person,
                    color: _currentState == 1 ?  Colors.white :  Colors.white54,
                ),
                  onPressed: () {
                    setState(() {
                      _currentState =1;
                    });
                  },
                  iconSize: 40,
                ),
              ],
            ),
          ),
        ),
        
      ),
      body: _screens[_currentState],
    );
  }
}
