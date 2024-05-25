import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_app/app_pages/sign_in.dart';

import '../common/sizes.dart';
import '../resources/auth_method.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';
import '../widgets/select_image.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final fullNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Uint8List? _image;           //using this we can also select image from web
  String? selectedImageName; // Variable to store the selected file name
  String? selectedRole;

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);

    return Scaffold(
        backgroundColor: const Color(0xff07aeaf),
        appBar: const MyAppBar(title: 'Sign Up'),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: sizes.height30),
              child: Container(height: sizes.height657,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(sizes.responsiveBorderRadius40),
                        topLeft: Radius.circular(sizes.responsiveBorderRadius40),
                    ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: sizes.height7),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Center(child: Padding(
                            padding: EdgeInsets.symmetric(vertical: sizes.height26),
                            child: Text('Logo', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizes.responsiveFontSize40,
                                ),),
                          ),),
                          Form(key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyText(text: 'Name'),
                                MyTextFormField(
                                  controller: fullNameController,
                                  hintText: 'full name',
                                  keyboardType: TextInputType.text,
                                ),
                                const MyText(text: 'Add Image'),
                                SelectImage(
                                  onTap: selectImage,
                                  selectedImageName:
                                    selectedImageName != null
                                      ? (selectedImageName!.length > 10
                                        ? '${selectedImageName!.substring(0, 10)}...'
                                        : selectedImageName!)
                                      : 'Image name',
                                ),
                                const MyText(text: 'Email'),
                                MyTextFormField(
                                  controller: emailController,
                                  hintText: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                const MyText(text: 'Password'),
                                MyTextFormField(
                                  controller: passwordController,
                                  hintText: 'password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.grey.shade500,
                                  ),
                                  suffixIcon: Icon(Icons.visibility, color: Colors.grey.shade500,),
                                ),
                              ],),),],
                      ),
                      SizedBox(height: sizes.height90,),
                      RoundButton(
                          title: 'Sign Up',
                          loading: loading,
                          onTap: () {
                            if ('Admin'.isNotEmpty) {
                              //for displaying this use isNotEmpty   and for not use isEmpty
                              showRoleSelectionDialog();
                            } else {
                              signupUser('Employee');
                            }
                          }),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.black, fontSize: sizes.responsiveFontSize14),
                          ),
                          InkWell(
                              onTap: () {
                                Get.to(() => const SignIn());
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: sizes.responsiveFontSize16),
                              ),
                          ),],),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void selectImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String fileName = pickedFile.name; // Extracting the file name
      Uint8List imageBytes = await pickedFile.readAsBytes();

      setState(() {
        _image = imageBytes;
        selectedImageName = fileName;
      });
    }
  }

  void signupUser(String role) async {
      setState(() {
        loading = true;
      });

      // users data for signup
      await AuthMethod().signupUser(
        fullName: fullNameController.text,
        email: emailController.text,
        password: passwordController.text,
        file: _image!,
        role: role,
      );
      Get.to(() => const SignIn());

      setState(() {
        loading = false;
      });
  }

  Future<void> showRoleSelectionDialog() async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Select Role,'),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Set the pressed color for Admin button
                      return const Color(0xff07aeaf); // Replace with your desired color
                    }
                    return Colors.transparent; // Default color
                  },
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Set the pressed color for Admin button
                      return Colors.transparent; // Replace with your desired color
                    }
                    return Colors.transparent; // Default color
                  },
                ),
              ),
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  signupUser('Admin');
                } else {
                  // Form validation failed, show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all the required fields.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Admin', style: TextStyle(color: Colors.black),),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Set the pressed color for Admin button
                      return const Color(0xff07aeaf); // Replace with your desired color
                    }
                    return Colors.transparent; // Default color
                  },
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      // Set the pressed color for Admin button
                      return Colors.transparent; // Replace with your desired color
                    }
                    return Colors.transparent; // Default color
                  },
                ),
              ),
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  signupUser('Employee');
                } else {
                  // Form validation failed, show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all the required fields.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Employee', style: TextStyle(color: Colors.black),),
            )
          ],
        );
      },
    );
  }
}

