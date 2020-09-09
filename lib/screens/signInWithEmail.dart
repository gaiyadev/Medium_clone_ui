import 'package:flutter/material.dart';
import 'package:medium_app/screens/signIn_screen.dart';
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
  TextEditingController _emailController = TextEditingController();

  String _errorText;
  bool _validate = false;
  bool _isLoading = false;

//Instance of network class for making api call
  NetworkHelper networkHelper = NetworkHelper();

  //Registration Logic
  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
//Checking
    final checkEmail = await _checkIfUserExist();
    if (checkEmail == false) {
      return;
    }

    if (!_globalKey.currentState.validate() || !_validate) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
// Getting data
    Map<String, String> _authData = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    //Now, making the API call
    try {
      await networkHelper
          .postData('/api/users/register', _authData)
          .then((_) => {
                setState(() {
                  _isLoading = false;
                })
              })
          .catchError((err) {
        print(err);
      });
    } catch (err) {
      throw err;
    }
  }

// Checking if User email already exist
  Future<dynamic> _checkIfUserExist() async {
    if (_emailController.text.length == 0) {
      setState(() {
        _isLoading = false;
        _validate = false;
        _errorText = 'Email cannot be empty';
      });
    } else {
      try {
        var response = await networkHelper
            .getData('/api/users/checkemail/${_emailController.text}');
        if (response['status']) {
          setState(() {
            _isLoading = false;
            _validate = false;
            _errorText = 'Email already taken';
          });
        } else {
          setState(() {
            _isLoading = false;
            _validate = true;
          });
        }
      } catch (err) {
        throw err;
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
            validator: (value) {
              if (value.isEmpty) {
                return 'Username cannot be empty';
              }
              if (value.length < 4) {
                return 'Username must be morethan 6 char';
              }
              return null;
            },
            controller: _usernameController,
            keyboardType: TextInputType.text,
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
            // validator: (value) {
            //   if (value.isEmpty) {
            //     return 'Email cannot be empty';
            //   }
            //   if (!value.contains('@')) {
            //     return 'Email is invalid';
            //   }
            //   return null;
            // },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 8.0, 28, 18),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Already have an account?',
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: _submit,
                  child: Container(
                    width: 150.0,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
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
