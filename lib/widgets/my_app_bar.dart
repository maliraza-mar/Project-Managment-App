import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key,
    required this.title,
    this.backgroundColor = const Color(0xff07aeaf),
    this.automaticallyImplyLeading = false,
    this.elevation = 0,
    this.leading,
  });

  final String title;
  final Color? backgroundColor;
  final bool? automaticallyImplyLeading;
  final double? elevation;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      centerTitle: true,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading!,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
