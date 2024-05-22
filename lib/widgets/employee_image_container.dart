import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/sizes.dart';


class EmployeeImageCircleAvatar extends StatelessWidget {
  const EmployeeImageCircleAvatar({super.key,
    required this.imageUrl,
    required this.imageName,
    required this.onTap,
  });

  final String imageUrl;
  final String imageName;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            // Set the pressed color for Admin button
            return Colors.transparent; // Replace with your desired color
          }
          return Colors.transparent; // Default color
        },
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: sizes.width10,      //size from left given is = 10.
              right: sizes.width3,    //size from right given is = 3.
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: sizes.responsiveImageRadius35,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircleAvatar(
                radius: sizes.responsiveImageRadius35,
                backgroundColor: Colors.grey[200],
              ),
              errorWidget: (context, url, error) => CircleAvatar(
                radius: sizes.responsiveImageRadius35,
                backgroundColor: Colors.grey[200],
                child: const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: sizes.height10,
              left: sizes.width8,
            ),
            child: Text(imageName),
          ),
        ],
      ),
    );
  }
}


// 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'