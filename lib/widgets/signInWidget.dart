import 'package:flutter/material.dart';

class SignInWidget extends StatelessWidget {
  final String text;
  final TextStyle style;

  const SignInWidget({
    @required this.text,
    @required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
