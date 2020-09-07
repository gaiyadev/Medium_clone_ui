import 'package:flutter/material.dart';
import 'package:medium_app/utils/constants.dart';
import 'package:medium_app/widgets/signInWidget.dart';
import 'package:medium_app/widgets/textWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _boxContainerButtons(String path, String text) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Image.asset(
                path,
                height: 40.0,
                width: 40.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                text,
                style: kSocialSignInStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Medium Clone',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 25.0,
          ),
        ),
      ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
          child: Column(
            children: [
              // TextWidgets(
              //   text: 'Medium',
              // ),
              // SizedBox(
              //   height: mediaQuery.size.height / 6,
              // ),
              TextWidgets(
                text: 'Create stories for great people.',
              ),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons('images/google.png', 'Sign in with Google'),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons(
                'images/fbdownload.png',
                'Sign in with Facebook',
              ),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons(
                'images/email.png',
                'Sign in with Email',
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInWidget(
                    text: 'Already have an account?',
                    style: kAlreadyHaveAnAccountStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SignInWidget(
                    text: "SignIn",
                    style: kSignInStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
