import 'package:flutter/material.dart';

import '../app_pages/profile.dart';
import '../common/sizes.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.title,
    required this.leading,
    this.trailing = const Icon(Icons.navigate_next, color: Colors.black,),
    required this.onTap,
  });

  final String title;
  final Widget leading;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6)),
      margin: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height7),
      elevation: 0.2,
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(title),
        trailing: trailing,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6)),
      ),
    );
  }
}
