import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:tugasminggu4/views/login.dart';

class MyRichText extends StatelessWidget {
  final String describe;
  final VoidCallback link;
  final String linkText;
  const MyRichText({
    Key? key,
    required this.describe,
    required this.link,
    required this.linkText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: '$describe',
          style: TextStyle(
            color: Colors.white,
          ),
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = link,
              text: '$linkText',
              style: TextStyle(
                  color: Colors.greenAccent,
                  decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}
