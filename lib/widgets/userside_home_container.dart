import 'package:flutter/material.dart';

import '../common/sizes.dart';


class UsersideHomeContainer extends StatelessWidget {
  const UsersideHomeContainer({
    super.key,
    required this.title,
    required this.message,
    required this.icon, this.onTap,
  });

  final String title;
  final String message;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: sizes.height100,
        width: sizes.width152,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: .5,
                  offset: const Offset(1, 1)
              )
            ]
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: sizes.height15, left: sizes.width5),
                  child: Icon(icon,
                    size: sizes.responsiveIconSize30, color: Colors.grey.shade700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: sizes.width8, top: sizes.height12),
                  child: Text(title,
                    style: TextStyle(
                        fontSize: sizes.responsiveFontSize17,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: sizes.height7, left: sizes.width5, right: sizes.width2),
              child: Text(message,
                style: TextStyle(fontSize: sizes.responsiveFontSize11, color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }
}