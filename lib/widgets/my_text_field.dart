import 'package:flutter/material.dart';

import '../common/sizes.dart';


class MyTextFormField extends StatelessWidget {
  const MyTextFormField({super.key,
    required this.controller,
    required this.hintText,
    this.isDense = true,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final bool? isDense;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizes.width20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          isDense: isDense,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
              borderSide: BorderSide(
                  color: Colors.grey.shade100,
              ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
              borderSide: BorderSide(
                  color: Colors.grey.shade100,
              ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
