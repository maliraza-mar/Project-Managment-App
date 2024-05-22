import 'package:flutter/material.dart';

import '../common/sizes.dart';


class DateYearSelectionContainer extends StatelessWidget {
  const DateYearSelectionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height48,
      width: sizes.width144,             //width = 144
      margin: EdgeInsets.only(
        left: sizes.width20,            //left = 20,
        bottom: sizes.height20,      //bottom = 20
        top: sizes.height20,        //top = 20
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius15),      //responsiveRadius = 15
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: sizes.width20,            //left = 20
            ),
            child: const Text(
              'May 2023',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: sizes.width20,            //left = 20
            ),
            child: const Icon(Icons.keyboard_arrow_down_outlined),
          ),
        ],
      ),
    );
  }
}