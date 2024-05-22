import 'package:flutter/material.dart';

import '../common/sizes.dart';


class MyText extends StatelessWidget {
  const MyText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sizes.width24,       //horizontal width given to both left,right sizes are = 24
        vertical: sizes.height5,       //vertical height given to both top, bottom sizes are = 5.3
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: sizes.responsiveFontSize17,
        ),
      ),
    );
  }
}
