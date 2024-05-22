import 'package:flutter/material.dart';
import '../common/sizes.dart';


class UsersProjectsTimeContainer extends StatefulWidget {
  //final Map<String, dynamic> projectData;
  const UsersProjectsTimeContainer({
    super.key, required this.iconColor,
    required this.title,
    required this.titleId,
    required this.imageUrl,
    required this.projectId,
    //required this.projectData,
    required this.toDo,
  });

  final Color iconColor;
  final Widget toDo;
  final String title;
  final String titleId;
  final String imageUrl;
  final String projectId;

  @override
  State<UsersProjectsTimeContainer> createState() => _UsersProjectsTimeContainerState();
}

class _UsersProjectsTimeContainerState extends State<UsersProjectsTimeContainer> {
  // final ProjectsController controller = Get.put(ProjectsController());
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // List usersAllIdsList = [];

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Container(
      height: sizes.height126,
      width: sizes.width320,
      margin: EdgeInsets.symmetric(horizontal: sizes.width20, vertical: sizes.height10),
      decoration:BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius6)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: sizes.height12,
              left: sizes.width20,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius20),
                  child: Image.network(
                    widget.imageUrl,
                    //'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                    width: sizes.width70,
                    height: sizes.height70,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: sizes.height15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizes.width20, top: sizes.width10
                            ),
                            child: Text( widget.title ?? 'N/A',
                              // 'New House'
                              style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: sizes.width75, top: sizes.height10,
                            ),
                            child: Text('ID:  ${widget.titleId}',
                              //'ID:  1001',
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      SizedBox(height: sizes.height5,),
                      Padding(
                        padding: EdgeInsets.only(right: sizes.width70),
                        child: Text('Validity: 1 day',
                          style: TextStyle(fontSize: sizes.responsiveFontSize11),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: sizes.height7, left: sizes.width20, right: sizes.width18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.circle, color: widget.iconColor, size: sizes.responsiveIconSize12,),
                    widget.toDo,
                  ],
                ),
                Text('July 15, 2023  02:05 AM', style: TextStyle(fontSize: sizes.responsiveFontSize11),)
              ],
            ),
          )

        ],
      ),
    );
  }
}