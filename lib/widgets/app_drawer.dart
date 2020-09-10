import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: null,
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
    );
  }
}
