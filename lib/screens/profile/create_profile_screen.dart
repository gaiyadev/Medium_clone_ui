import 'package:flutter/material.dart';

class CreateProfileScren extends StatefulWidget {
  @override
  _CreateProfileScrenState createState() => _CreateProfileScrenState();
}

class _CreateProfileScrenState extends State<CreateProfileScren> {
  Widget _titleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.tealAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.title,
          color: Colors.greenAccent,
        ),
        labelText: 'Title',
        hintText: 'Mr/Mrs',
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.tealAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.greenAccent,
        ),
        labelText: 'Name',
        hintText: 'Your Name',
      ),
    );
  }

  Widget _proffessionTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.tealAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.greenAccent,
        ),
        labelText: 'Job Title',
        hintText: 'Your Job description',
      ),
    );
  }

  Widget _dobTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.tealAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.date_range,
          color: Colors.greenAccent,
        ),
        labelText: 'Data of Birth Title',
        hintText: 'Your Date of birth',
      ),
    );
  }

  Widget _aboutTextField() {
    return TextFormField(
      maxLines: 5,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.tealAccent,
            width: 2.0,
          ),
        ),
        prefixIcon: Icon(
          Icons.info,
          color: Colors.greenAccent,
        ),
        labelText: 'About',
        hintText: 'Your some text about youtself',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('Add Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            _titleTextField(),
            SizedBox(
              height: 20,
            ),
            _nameTextField(),
            SizedBox(
              height: 20,
            ),
            _proffessionTextField(),
            SizedBox(
              height: 20,
            ),
            _dobTextField(),
            SizedBox(
              height: 20,
            ),
            _aboutTextField(),
          ],
        ),
      ),
    );
  }
}
