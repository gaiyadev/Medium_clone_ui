import 'package:flutter/material.dart';
import 'package:medium_app/services/networkHelper.dart';
import 'package:medium_app/utils/constants.dart';

class SignInWithEmail extends StatefulWidget {
  static const String routeName = '/signInWithEmail';

  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool _iconVisibility = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailControler = TextEditingController();

  String _errorText;
  bool _validate = false;
  bool _isLoading = false;

//Instance of network class for making api call
  NetworkHelper networkHelper = NetworkHelper();

  //Registration
  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });

    await _checkIfUserExist();
    if (!_globalKey.currentState.validate() && !_validate) {
      return;
    }
// Getting data
    Map<String, String> _authData = {
      'username': _usernameController.text,
      'email': _emailControler.text,
      'password': _passwordController.text,
    };
    //Now, making the API call
    try {
      await networkHelper.userRegistration('api/users/register', _authData);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      //show digload
      setState(() {
        _isLoading = false;
      });
    }
  }

// Checking if User already exist by email
  Future<void> _checkIfUserExist() async {
    if (_emailControler.text.length == 0) {
      setState(() {
        _isLoading = false;
        _validate = false;
        _errorText = 'Email cannot be empty';
      });
    } else {
      try {
        var response = await networkHelper
            .getData('api/users/checkEmail/${_emailControler.text}');
        if (response['status']) {
          setState(() {
            //_isLoading = false;
            _validate = false;
            _errorText = 'Email address already taken';
          });
        } else {
          setState(() {
            _validate = true;
          });
        }
      } catch (e) {
        throw e;
      }
    }
  }

//...
  Widget _usernmameTextFields(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Username cannot be empty';
              }
              return null;
            },
            decoration: InputDecoration(
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

  Widget _emailTextFields(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            controller: _emailControler,
            keyboardType: TextInputType.emailAddress,
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Email cannot be empty';
            //   }
            //   if (!value.contains('@')) {
            //     return 'Email IS invalid ';
            //   }
            //   return null;
            // },
            decoration: InputDecoration(
              errorText: _validate ? null : _errorText,
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
              if (value.length < 6) {
                return 'Password length must be morethan 6 char ';
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
              helperText: 'Please password length must be morethan6',
              helperStyle: TextStyle(
                fontSize: 17,
              ),
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

  Widget _confirmPasswordTextFields(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Text(label),
          TextFormField(
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match!';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
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
                    'Sign up with email',
                    style: kSignInTitleStyle,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _usernmameTextFields('Username'),
                _emailTextFields('Email'),
                _passwordTextFields('Password'),
                _confirmPasswordTextFields('Confirm Password'),
                SizedBox(
                  height: 20.0,
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
                              'SignUp',
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
