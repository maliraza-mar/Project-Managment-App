import 'package:flutter/material.dart';

import '../common/sizes.dart';


class SelectImage extends StatefulWidget {
  const SelectImage({super.key, required this.onTap, required this.selectedImageName});

  final void Function() onTap;
  final String selectedImageName;

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height55,
      margin: EdgeInsets.symmetric(horizontal: sizes.width20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.onTap,
            child: Container(
              height: sizes.height40,
              width: sizes.width134,
              margin: EdgeInsets.only(left: sizes.width8),
              decoration: BoxDecoration(
                  color: const Color(0xff07aeaf),
                  borderRadius:
                  BorderRadius.circular(sizes.responsiveBorderRadius8)),
              child: Center(
                child: Text('Choose Image',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizes.responsiveFontSize16)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: sizes.width8),
            child: Text(widget.selectedImageName,
              // Display selected file name or 'File name'
              // if none is selected
              overflow: TextOverflow.ellipsis,
              // Handle overflow with ellipsis
              style: TextStyle(
                  color: Colors.black, fontSize: sizes.responsiveFontSize16),
            ),
          )
        ],
      ),
    );
  }

  // Future getGalleryImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       selectedImageName = pickedFile.name;
  //     } else {
  //       print('no image picked');
  //     }
  //   });
  // }

  //Image selected with dots after length exceeds 10
  // selectedImageName != null
  // ? (selectedImageName!.length > 10
  // ? selectedImageName!
  //     .substring(0, 10) +
  // '...'
  //     : selectedImageName!)
  //     : 'Image name'
}
