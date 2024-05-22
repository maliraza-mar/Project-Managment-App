import 'package:flutter/material.dart';
import '../common/sizes.dart';

class UsersideCompMissTodoContainer extends StatelessWidget {
  const UsersideCompMissTodoContainer({
    Key? key,
    required this.titleName,
    required this.containerColor,
    required this.textColor,
    required this.numbersColor,
    this.toDo,
  });

  final String titleName;
  final Color containerColor;
  final Color textColor;
  final Color numbersColor;
  final Widget? toDo;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height126,
      width: sizes.width320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6),
        color: containerColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (titleName.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(top: sizes.height10, left: sizes.width15),
              child: Text(
                titleName,
                style: TextStyle(
                  fontSize: sizes.responsiveFontSize20,
                  fontWeight: FontWeight.bold,
                  color: numbersColor,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizes.width15, vertical: sizes.height15),
                  child: Column(
                    children: [
                      Text(
                        '20',
                        style: TextStyle(
                          color: numbersColor,
                          fontWeight: FontWeight.bold,
                          fontSize: sizes.responsiveFontSize23,
                        ),
                      ),
                      Text('Completed', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(
                    color: textColor,
                    fontSize: sizes.responsiveFontSize50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizes.width15, vertical: sizes.height15),
                  child: Column(
                    children: [
                      Text(
                        '02',
                        style: TextStyle(
                          color: numbersColor,
                          fontWeight: FontWeight.bold,
                          fontSize: sizes.responsiveFontSize23,
                        ),
                      ),
                      Text('Missed', style: TextStyle(color: textColor)),
                    ],
                  ),
                ),
                Text(
                  '|',
                  style: TextStyle(
                    color: textColor,
                    fontSize: sizes.responsiveFontSize50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizes.width24, vertical: sizes.height15),
                  child: toDo,
                )
              ],
            ),
          ],
          if (titleName.isEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: sizes.height20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.width15, vertical: sizes.height15),
                    child: Column(
                      children: [
                        Text(
                          '20',
                          style: TextStyle(
                            color: numbersColor,
                            fontWeight: FontWeight.bold,
                            fontSize: sizes.responsiveFontSize23,
                          ),
                        ),
                        Text(
                          'Completed',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      color: textColor,
                      fontSize: sizes.responsiveFontSize50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.width15, vertical: sizes.height15),
                    child: Column(
                      children: [
                        Text(
                          '02',
                          style: TextStyle(
                            color: numbersColor,
                            fontWeight: FontWeight.bold,
                            fontSize: sizes.responsiveFontSize23,
                          ),
                        ),
                        Text(
                          'Missed',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      color: textColor,
                      fontSize: sizes.responsiveFontSize50,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizes.width24, vertical: sizes.height15),
                    child: toDo,
                  )
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

}
