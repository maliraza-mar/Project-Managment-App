import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/sizes.dart';
import '../model/user_model.dart';
import '../resources/storage_methods.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';

class Profile extends StatefulWidget {
  final UserModel user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeEmailController = TextEditingController();
  final TextEditingController employeePasswordController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  Uint8List _imageBytes = Uint8List(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    employeeNameController.text = widget.user.fullName ?? ''; // Set initial value
    employeeEmailController.text = widget.user.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);
    print('${widget.user.email}');
    print('${widget.user.password}');

    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          iconSize: sizes.responsiveIconSize18,
        ),
        title: 'Profile',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height100),
            child: Container(
              height: sizes.height588,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40),
                  ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: sizes.height40,),
                          child: Center(
                            child: GestureDetector(
                              //onTap: _selectImage,
                              child: CircleAvatar(
                                radius: sizes.responsiveImageRadius60,
                                backgroundImage: _imageBytes.isNotEmpty
                                    ? Image.memory(_imageBytes, fit: BoxFit.cover,).image
                                    : NetworkImage(widget.user.imageUrl ?? 'https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_640.png'),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: sizes.height37,),

                        //Employee Name
                        const MyText(text: 'Name'),
                        MyTextFormField(
                          controller: employeeNameController,
                          hintText: 'Employee name',
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey.shade400,),
                        ),

                        //Employee Email
                        const MyText(text: 'Enter Email'),
                        MyTextFormField(
                          controller: employeeEmailController,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade400,),
                        ),
                      ],
                    ),

                    //Update Button
                    // RoundButton(
                    //   title: 'Update',
                    //   onTap: () async{
                    //     await FirebaseAuth.instance.currentUser?.updateDisplayName(employeeNameController.text);
                    //   },
                    //   //loading: loading,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

  // Function to open image picker
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });

      // Upload image to Firebase Storage
      String imageUrl = await StorageMethods().uploadImageToStorage('ProfilePic', _imageBytes);
      print('Image uploaded to Firebase Storage. Download URL: $imageUrl');

      // After successful upload, update user profile with image URL
      if (imageUrl.isNotEmpty) {
        await _updateUserProfile(imageUrl,);
      }
    }
  }
  Future<void> _updateUserProfile(String imageUrl) async {
    try {
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
      print('User profile updated successfully with image URL: $imageUrl');
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

}

