import 'package:flutter/material.dart';


class Sizes {
  final BuildContext context;
  Sizes(this.context);
  Size get size => MediaQuery.of(context).size;

  //Icon Sizes
  double get responsiveIconSize12 => size.width < size.height                  //size = 14.8
      ? size.width * 0.0332
      : size.height * 0.0332;
  double get responsiveIconSize15 => size.width < size.height
      ? size.width * 0.0418
      : size.height * 0.0418;
  double get responsiveIconSize18 => size.width < size.height
      ? size.width * 0.05 // Adjust the factor as needed
      : size.height * 0.05;
  double get responsiveIconSize20 => size.width < size.height
      ? size.width * 0.0555
      : size.height * 0.0555;
  double get responsiveIconSize25 => size.width < size.height
      ? size.width * 0.072
      : size.height * 0.072;
  double get responsiveIconSize30 => size.width < size.height                  //size = 29.9
      ? size.width * 0.083
      : size.height * 0.083;
  double get responsiveIconSize54 => size.width < size.height
      ? size.width * 0.15 // Adjust the factor as needed
      : size.height * 0.15;


  //font Sizes
  double get responsiveFontSize9 => size.width < size.height                   //size = 9.4
      ? size.width * 0.026
      : size.height * 0.026;
  double get responsiveFontSize11 => size.width < size.height                  //size = 11.2
      ? size.width * 0.031
      : size.height * 0.031;
  double get responsiveFontSize12 => size.width < size.height                  //size = 14.8
      ? size.width * 0.0332
      : size.height * 0.0332;
  double get responsiveFontSize14 => size.width < size.height                  //size = 14.8
      ? size.width * 0.041
      : size.height * 0.041;
  double get responsiveFontSize16 => size.width < size.height
      ? size.width * 0.0444
      : size.height * 0.0444;
  double get responsiveFontSize17 => size.width < size.height
      ? size.width * 0.0472
      : size.height * 0.0472;
  double get responsiveFontSize18 => size.width < size.height
      ? size.width * 0.05
      : size.height * 0.05;
  double get responsiveFontSize20 => size.width < size.height
      ? size.width * 0.0555
      : size.height * 0.0555;
  double get responsiveFontSize23 => size.width < size.height
      ? size.width * 0.064
      : size.height * 0.064;
  double get responsiveFontSize28 => size.width < size.height                  //size = 28.1
      ? size.width * 0.078
      : size.height * 0.078;
  double get responsiveFontSize34 => size.width < size.height
      ? size.width * 0.0945
      : size.height * 0.0945;
  double get responsiveFontSize40 => size.width < size.height
      ? size.width * 0.111
      : size.height * 0.111;
  double get responsiveFontSize50 => size.width < size.height
      ? size.width * 0.139
      : size.height * 0.139;


  //Border Radius
  double get responsiveBorderRadius66 => size.width < size.height
      ? size.width * 0.1833
      : size.height * 0.1833;
  double get responsiveBorderRadius50 => size.width < size.height
      ? size.width * 0.139
      : size.height * 0.139;
  double get responsiveBorderRadius40 => size.width < size.height
      ? size.width * 0.111
      : size.height * 0.111;
  double get responsiveBorderRadius30 => size.width < size.height
      ? size.width * 0.0834
      : size.height * 0.0834;
  double get responsiveBorderRadius20 => size.width < size.height
      ? size.width * 0.0555
      : size.height * 0.0555;
  double get responsiveBorderRadius15 => size.width < size.height
      ? size.width * 0.0418
      : size.height * 0.0418;
  double get responsiveBorderRadius10 => size.width < size.height
      ? size.width * 0.0278
      : size.height * 0.0278;
  double get responsiveBorderRadius8 => size.width < size.height
      ? size.width * 0.0222
      : size.height * 0.0222;
  double get responsiveBorderRadius6 => size.width < size.height                //radius = 6.5
      ? size.width * 0.018
      : size.height * 0.018;


  //Images Radius
  double get responsiveImageRadius70 => size.width < size.height               //y abi check krna h
      ? size.width * 0.19
      : size.height * 0.19;
  double get responsiveImageRadius65 => size.width < size.height                //radius = 65.2
      ? size.width * 0.181
      : size.height * 0.181;
  double get responsiveImageRadius60 => size.width < size.height                //radius = 60.1
      ? size.width * 0.167
      : size.height * 0.167;
  double get responsiveImageRadius35 => size.width < size.height
      ? size.width * 0.0972
      : size.height * 0.0972;
  double get responsiveImageRadius30 => size.width < size.height
      ? size.width * 0.0834
      : size.height * 0.0834;
  double get responsiveImageRadius25 => size.width < size.height
      ? size.width * 0.072
      : size.height * 0.072;
  double get responsiveImageRadius23 => size.width < size.height
      ? size.width * 0.064
      : size.height * 0.064;


  //Top, Bottom, Height, vertical
  double get height1 => size.height / 740;
  double get height3 => size.height / 260;
  double get height5 => size.height / 154;
  double get height7 => size.height / 111.3;                    //height = 6.9
  double get height10 => size.height / 77;
  double get height12 => size.height / 64.5;
  double get height15 => size.height / 51.5;
  double get height20 => size.height / 38.6;
  double get height25 => size.height / 30.8;
  double get height26 => size.height / 29.7;
  double get height30 => size.height / 25.7;
  double get height35 => size.height / 22;                   //height = 35.1
  double get height37 => size.height / 20.8;                 //height = 37.1
  double get height40 => size.height / 19.3;
  double get height48 => size.height / 16;                   //height = 48.3
  double get height52 => size.height / 14.8;                  //height = 52.2
  double get height55 => size.height / 13.99;                //height = 55.2
  double get height60 => size.height / 12.8;                //height = 50.3
  double get height65 => size.height / 11.9;                //height = 64.9
  double get height70 => size.height / 11;                //height = 70.2
  double get height80 => size.height / 9.87;                //height =
  double get height90 => size.height / 8.57;                 //height = 90.1
  double get height100 => size.height / 7.72;
  double get height110 => size.height / 7;                   //height = 110.3
  double get height115 => size.height / 6.7;                   //height = 115.2
  double get height119 => size.height / 6.43;                   //height = 110.3
  double get height126 => size.height / 6.125;
  double get height140 => size.height / 5.51;                  //height = 140.1
  double get height148 => size.height / 5.21;                  //height = 148.2
  double get height150 => size.height / 5.14;                  //height = 150.2
  double get height220 => size.height / 3.5;                 //height = 220.6
  double get height300 => size.height / 2.573;
  double get height510 => size.height / 1.513;               //height = 510.2
  double get height540 => size.height / 1.429;               //height = 540.2
  double get height588 => size.height / 1.312;               //height = 588.4
  double get height627 => size.height / 1.23;               //height = 627.6
  double get height652 => size.height / 1.184;
  double get height657 => size.height / 1.1741;              //height = 657.5
  double get height677 => size.height / 1.139;               //height = 677.7


  //Left, Right, width, Horizontal
  double get width2 => size.width / 178;
  double get width3 => size.width / 120;
  double get width5 => size.width / 72;
  double get width8 => size.width / 45;
  double get width9 => size.width / 40;                     //width = 9
  double get width10 => size.width / 35.9;
  double get width12 => size.width / 30;
  double get width13 => size.width / 27.7;
  double get width15 => size.width / 24;
  double get width18 => size.width / 20;
  double get width20 => size.width / 18;
  double get width24 => size.width / 15;
  double get width30 => size.width / 12;
  double get width35 => size.width / 10.3;
  double get width40 => size.width / 9;
  double get width45 => size.width / 8.5;
  double get width50 => size.width / 7.5;                  //khud s estimate lgaya
  double get width70 => size.width / 5.14;
  double get width75 => size.width / 4.8;
  double get width100 => size.width / 3.6;
  double get width106 => size.width / 3.396;
  double get width124 => size.width / 2.9;                  //width = 124.1
  double get width134 => size.width / 2.686;                  //width = 124.1
  double get width144 => size.width / 2.5;                  //width = 144
  double get width150 => size.width / 2.4;
  double get width152 => size.width / 2.369;
  double get width320 => size.width / 1.125;
}
