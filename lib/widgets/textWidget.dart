import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:medium_app/utils/constants.dart';

class TextWidgets extends StatelessWidget {
  final String text;

  const TextWidgets({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: kTitleTextStyle,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }
}
