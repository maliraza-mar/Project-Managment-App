import 'package:flutter/material.dart';

import '../../common/sizes.dart';

class ProjectsDetails extends StatefulWidget {
  const ProjectsDetails({super.key});

  @override
  State<ProjectsDetails> createState() => _ProjectsDetailsState();
}

class _ProjectsDetailsState extends State<ProjectsDetails> {
  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
          iconSize: sizes.responsiveIconSize18,
        ),
        title: const Text('Project Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: sizes.width10),
            child: CircleAvatar(
              radius: sizes.responsiveImageRadius23,
              backgroundImage: const NetworkImage('https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
            ),
          ),
        ],
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: sizes.height5,
                left: sizes.width20,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
                      width: sizes.width106,
                      height: sizes.height110,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: sizes.height20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizes.width45
                          ),
                          child: Text('New House',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: sizes.responsiveFontSize18),),
                        ),
                        SizedBox(height: sizes.height5,),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizes.width45
                          ),
                          child: Text('Project ID:  1001', style: TextStyle(fontSize: sizes.responsiveFontSize12),),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            //Project Info part here
            Padding(
              padding: EdgeInsets.only(
                left: sizes.width18,
              ),
              child: Text('Project Info',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: sizes.responsiveFontSize17),),
            ),

            const ProjectInfoDetailsWithTitle(text: 'Created At:   30-June-2023',),
            const ProjectInfoDetailsWithTitle(text: 'Deadline:   30-June-2023',),
            const ProjectInfoDetailsWithTitle(text: 'Budget:   \$500',),
            const ProjectInfoDetailsWithTitle(text: 'Status:   Completed',),

            Padding(
              padding: EdgeInsets.only(
                  left: sizes.width18,
                  top: sizes.height52
              ),
              child: Text('Instructions',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: sizes.responsiveFontSize18,
                ),
              ),
            ),

            //TextForm Field here for a message from user
            Padding(
              padding: EdgeInsets.symmetric(vertical: sizes.height20, horizontal: sizes.width18),
              child: TextFormField(
                minLines: 6,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has "
                      "been the industry's standard dummy text ever since the 1500s.",
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ProjectInfoDetailsWithTitle extends StatelessWidget {
  const ProjectInfoDetailsWithTitle({
    super.key, required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Padding(
      padding: EdgeInsets.only(
          left: sizes.width18,
          top: sizes.height10
      ),
      child: Text(text, style: const TextStyle(color: Colors.black),),
    );
  }
}
