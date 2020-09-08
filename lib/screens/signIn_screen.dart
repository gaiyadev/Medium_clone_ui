import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medium_app/screens/forgot_password_screen.dart';
import 'package:medium_app/screens/home_screen.dart';
import 'package:medium_app/services/networkHelper.dart';
import 'package:medium_app/utils/constants.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signIn';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _iconVisibility = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  // String _errorText;
  // bool _validate = false;
  bool _isLoading = false;

//Instance of network class for making api call
  NetworkHelper networkHelper = NetworkHelper();

  //Registration Logic
  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (!_globalKey.currentState.validate()) {
      return;
    }
// Getting data
    Map<String, String> _authData = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    print(_authData);
    //Now, making the API call
    try {
      var response = await networkHelper.userAuth('api/users/login', _authData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> authToken = jsonDecode(response.body);
        print(authToken['token']);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
        });
        print(response.statusCode);
        print(data);
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      throw err;
    }
  }

  Widget _emailTextFields(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Email cannot be blank';
              }
              return null;
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              // errorText: _validate ? null : _errorText,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordTextFields(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            },
            obscureText: _iconVisibility,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: Icon(
                    _iconVisibility ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _iconVisibility = !_iconVisibility;
                    });
                  }),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
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
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mediaQuery.size.height,
        width: mediaQuery.size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green,
            ],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(1.0, 0.1),
            stops: [0.0, 2.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 78),
                  child: Text(
                    'Sign In with Email',
                    style: kSignInTitleStyle,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // _usernmameTextFields('Username'),
                _emailTextFields('Email'),
                _passwordTextFields('Password'),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(29.0, 8.0, 29.0, 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text('Forgot password'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        },
                        child: Text("Don't have an account?"),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: _submit,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Container(
                          width: 150.0,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'SignIn',
                              style: kSignInTitleStyle,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
