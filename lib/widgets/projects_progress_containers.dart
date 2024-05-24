import 'package:flutter/material.dart';

import '../common/sizes.dart';


class ProjectProgressContainers extends StatelessWidget {
  const ProjectProgressContainers({
    super.key, this.figureText, required this.wordText,
  });

  final int? figureText;
  final String wordText;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      margin: EdgeInsets.symmetric(
        //horizontal: sizes.width15,        //horizontal approx. = 9
        vertical: sizes.height20,        //vertical approx. = 7.7
      ),
      padding: EdgeInsets.symmetric(
        vertical: sizes.height30,        //top = 26
        horizontal: sizes.width118
      ),
      decoration: BoxDecoration(
        color: const Color(0xff07aeaf),
        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20),     //radius = 20
      ),
      child: Column(
        children: [
          Text(figureText.toString(),
            style: TextStyle(
                fontSize: sizes.responsiveFontSize40,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Text(wordText,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}