import 'package:flutter/material.dart';

import '../common/sizes.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading ;
  const RoundButton({super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        width: sizes.width320,
        height: sizes.height52,
        margin: EdgeInsets.symmetric(horizontal: sizes.width20),
        decoration: BoxDecoration(
            color: const Color(0xff07aeaf),
            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10)),
        child: Center(child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) :
         Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: sizes.responsiveFontSize18,
              fontWeight: FontWeight.bold),
        ),),
      ),
    );
  }
}
