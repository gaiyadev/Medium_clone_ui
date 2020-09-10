import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileScren extends StatefulWidget {
  @override
  _CreateProfileScrenState createState() => _CreateProfileScrenState();
}

class _CreateProfileScrenState extends State<CreateProfileScren> {
  PickedFile _image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    setState(() {
      _image = pickedFile;
    });
  }

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

  Widget _imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _image == null
                ? AssetImage('images/pic.png')
                : FileImage(
                    File(_image.path),
                  ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => _bottomSheet()),
                );
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text('Choose profilep ic'),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('Camera'),
              ),
              FlatButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('Gallery'),
              ),
            ],
          ),
        ],
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
            _imageProfile(),
            SizedBox(
              height: 20,
            ),
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
