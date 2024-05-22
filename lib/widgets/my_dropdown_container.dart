import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/sizes.dart';


class MyDropDownContainer extends StatefulWidget {
  MyDropDownContainer({super.key,
    required this.text,
    required this.itemsList,
    required this.value,
    required this.onChanged,
  });

  final String text;
  final List<dynamic> itemsList;
  String? value;
  final ValueChanged<String?> onChanged;

  @override
  State<MyDropDownContainer> createState() => _MyDropDownContainerState();
}

class _MyDropDownContainerState extends State<MyDropDownContainer> {
  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height55,
      margin: EdgeInsets.symmetric(
        horizontal: sizes.width20,
      ),
      padding: EdgeInsets.only(
        left: sizes.width12,
        right: sizes.width10,
        top: sizes.height3,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100, width: 1),
        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
      ),
      child: DropdownButton(
        hint: Text(
          widget.text,
          style: TextStyle(fontSize: sizes.responsiveFontSize16),
        ),
        dropdownColor: Colors.white,
        underline: const SizedBox(),
        iconSize: sizes.responsiveIconSize30,
        iconEnabledColor: Colors.grey.shade500,
        isExpanded: true,
        style: TextStyle(color: Colors.black, fontSize: sizes.responsiveFontSize16),
        items: widget.itemsList.map((valueItem) {
          return DropdownMenuItem(
            value: valueItem,
            child: Text(valueItem.toString()),
          );
        }).toList(),
        value: widget.value,
        onChanged: (newValue) {
          setState(() {
            widget.value = newValue as String?;
            widget.onChanged(widget.value);
          });
        },
      ),
    );
  }
}
