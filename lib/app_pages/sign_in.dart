import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_app/app_pages/sign_up.dart';
import 'package:project_app/app_pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/sizes.dart';
import '../controllers/sign_in_controller.dart';
import '../navbar_page.dart';
import '../user_side_pages.dart';
import '../utilities/utils.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text.dart';
import '../widgets/my_text_field.dart';
import '../widgets/round_button.dart';

class SignIn extends StatefulWidget {
  //static const String id = 'sign_in';
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  final SignInController controller = Get.put(SignInController());
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final sizes = Sizes(context);
    return Scaffold(
      backgroundColor: const Color(0xff07aeaf),
      appBar: const MyAppBar(title: 'Sign In'),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: sizes.height60),
            child: Container(
              height: sizes.height627,
              decoration: BoxDecoration(color: Colors.grey.shade100,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(sizes.responsiveBorderRadius40),
                      topLeft: Radius.circular(sizes.responsiveBorderRadius40))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizes.height7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: sizes.height35,
                              horizontal: sizes.width40),
                          child: Center(
                            child: Text('Logo',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: sizes.responsiveFontSize40)),),
                        ),
                        Container(
                          height: sizes.height60,
                          margin: EdgeInsets.only(
                            left: sizes.width20, right: sizes.width20, top: sizes.height48),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _twoButtons(context, button: 0, label: 'Admin'),
                                _twoButtons(context, button: 1, label: 'Employee'),
                              ],),),),
                        Form(key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //Email & Password Section start here
                                const MyText(text: 'Enter Email'),
                                MyTextFormField(
                                  controller: emailController,
                                  hintText: 'email',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: Colors.grey.shade500,),),
                                const MyText(text: 'Password'),
                                MyTextFormField(
                                  controller: passwordController,
                                  hintText: 'password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.grey.shade500,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.visibility,
                                    color: Colors.grey.shade500,),),],
                            )),
                      ],
                    ),
                    SizedBox(height: sizes.height115,),
                    RoundButton(
                        title: 'Sign In',
                        loading: loading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                          clearText();}),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                          style: TextStyle(color: Colors.black,
                              fontSize: sizes.responsiveFontSize14),),
                        InkWell(
                            onTap: () {
                              Get.to(() => const SignUp());},
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: sizes.responsiveFontSize16),
                            ))
                      ],)],),),),)],),);
  }
  //Login ka Function bnaya h
  void login() {
    setState(() {loading = true;});
    _auth.signInWithEmailAndPassword(
      email: emailController.text.toString(), password: passwordController.text.toString(),
    ).then((value) async {
      Utils().toastMessage(value.user!.email.toString());
      final currentUserUid = FirebaseAuth.instance.currentUser?.email;
      var sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setBool(SplashScreenState.keyLogin, true);
      sharedPreference.setBool(SplashScreenState.isAdmin,
          controller.currentButton.value == 0 ? true : false);
      Get.to(() => controller.currentButton.value == 0
          ? const NavBarPage()
          : const UserSidePages());
      setState(() {loading = false;});
    }).onError((error, stackTrace) {debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {loading = false;});
    });
  }
  //TextField s text ko clear krny k liy y Function bnaya h
  void clearText() {
    emailController.clear();
    passwordController.clear();
  }
  Widget _twoButtons(BuildContext context, {required button, required label}) {
    final sizes = Sizes(context);
    return InkWell(
      onTap: () {controller.goToButton(button);},
      child: Container(height: sizes.height52, width: sizes.width150,
          decoration: BoxDecoration(color: controller.currentButton.value == button
                ? const Color(0xff07aeaf)
                : Colors.white,
            borderRadius: BorderRadius.circular(sizes.responsiveBorderRadius10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: controller.currentButton.value == button
                      ? Colors.white : Colors.black,
                  fontSize: sizes.responsiveFontSize17),),
          )),
    );
  }
}
