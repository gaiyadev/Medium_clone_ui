import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medium_app/screens/profile/create_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _button() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AutoSizeText(
            'Tap to add Profile data',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.tealAccent,
              fontSize: 29,
            ),
            maxLines: 1,
          ),
          SizedBox(
            height: 30.0,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateProfileScren(),
                ),
              );
            },
            child: Container(
              height: 60.0,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: const AutoSizeText(
                  'Add Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _button(),
    );
  }
}
