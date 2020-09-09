import 'package:flutter/material.dart';
import 'package:medium_app/screens/signInWithEmail.dart';
import 'package:medium_app/screens/signIn_screen.dart';
import 'package:medium_app/utils/constants.dart';
import 'package:medium_app/widgets/signInWidget.dart';
import 'package:medium_app/widgets/textWidget.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //Animation2
  AnimationController _controller1;
  Animation<Offset> animation1;

  //Animation2
  AnimationController _controller2;
  Animation<Offset> animation2;

  Widget _boxContainerButtons({String path, String text, Function onTap}) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onTap,
        child: Container(
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
        ),
      ),
    );
  }

  void onTap() {}

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: Duration(
        milliseconds: 1500,
      ),
      vsync: this,
    );
    animation1 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.1),
    ).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeInOutBack,
      ),
    );

    //Controller2
    _controller2 = AnimationController(
      duration: Duration(
        milliseconds: 3000,
      ),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.1),
    ).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInBack,
      ),
    );
    //
    _controller1.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: SlideTransition(
          position: animation1,
          child: const Text(
            'Medium Clone',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 25.0,
            ),
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
              SlideTransition(
                position: animation1,
                child: TextWidgets(
                  text: 'Create stories for great people.',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons(
                  path: 'images/google.png',
                  text: 'Sign in with Google',
                  onTap: null),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons(
                path: 'images/fbdownload.png',
                text: 'Sign in with Facebook',
                onTap: null,
              ),
              SizedBox(
                height: 20,
              ),
              _boxContainerButtons(
                path: 'images/email.png',
                text: 'Sign in with Email',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignInWithEmail(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              SlideTransition(
                position: animation2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInWidget(
                      text: 'Already have an account?',
                      style: kAlreadyHaveAnAccountStyle,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: SignInWidget(
                        text: "SignIn",
                        style: kSignInStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
