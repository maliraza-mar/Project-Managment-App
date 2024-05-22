import 'package:flutter/material.dart';

import '../common/sizes.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizes = Sizes(context);

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
        title: 'Reset Password',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height148),
            child: Container(
              height: sizes.height540,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40),
                      topRight: Radius.circular(sizes.responsiveBorderRadius40)
                  )
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
                        SizedBox(height: sizes.height20,),
                        //old password
                        const MyText(text: 'Old Password'),
                        MyTextFormField(
                            controller: oldPasswordController,
                            hintText: '*****',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),

                        //New password
                        const MyText(text: 'New Password'),
                        MyTextFormField(
                            controller: newPasswordController,
                            hintText: '**********',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),

                        //Confirm Password
                        const MyText(text: 'Confirm Password'),
                        MyTextFormField(
                            controller: confirmPasswordController,
                            hintText: '**********',
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey.shade400,)
                        ),
                      ],
                    ),

                    //Button
                    RoundButton(title: 'Reset', onTap: (){}),
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
