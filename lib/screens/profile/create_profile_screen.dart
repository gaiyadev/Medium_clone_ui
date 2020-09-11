import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medium_app/screens/home_screen.dart';
import 'package:medium_app/services/networkHelper.dart';

class CreateProfileScren extends StatefulWidget {
  @override
  _CreateProfileScrenState createState() => _CreateProfileScrenState();
}

class _CreateProfileScrenState extends State<CreateProfileScren> {
  PickedFile _image;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );

    setState(() {
      _image = pickedFile;
    });
  }

  bool _circular = false;
  NetworkHelper networkHelper = NetworkHelper();
  Widget _titleTextField() {
    return TextFormField(
      controller: _title,
      validator: (value) {
        if (value.isEmpty) {
          return 'Title cannot be empty';
        }
        return null;
      },
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
      controller: _name,
      validator: (value) {
        if (value.isEmpty) {
          return 'Name cannot be empty';
        }
        return null;
      },
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
      controller: _profession,
      validator: (value) {
        if (value.isEmpty) {
          return 'Profession cannot be empty';
        }
        return null;
      },
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
      controller: _dob,
      validator: (value) {
        if (value.isEmpty) {
          return 'Date of birth cannot be empty';
        }
        return null;
      },
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
      controller: _about,
      validator: (value) {
        if (value.isEmpty) {
          return 'About cannot be empty';
        }
        return null;
      },
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
      body: _circular
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _globalKey,
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
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FlatButton(
                        color: Colors.teal,
                        onPressed: () async {
                          setState(() {
                            _circular = true;
                          });
                          if (_globalKey.currentState.validate()) {
                            Map<String, String> profileData = {
                              'name': _name.text,
                              'title': _title.text,
                              'profession': _profession.text,
                              'dob': _dob.text,
                              'about': _about.text,
                            };
                            Response response = await networkHelper.postData(
                                '/api/users/profile/add', profileData);
                            if (response.statusCode == 200) {
                              //success

                              if (_image.path != null) {
                                var responseImage =
                                    await networkHelper.patchImge(
                                        '/api/users/profile/add/image',
                                        _image.path);
                                if (responseImage.statusCode == 200) {
                                  //success
                                } else {
                                  print(responseImage.statusCode);
                                }
                              }
                            } else {
                              setState(() {
                                _circular = false;
                              });
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ),
                                  (route) => false);
                              print(response.statusCode);
                            }
                          } else {
                            setState(() {
                              _circular = false;
                            });
                            return;
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
