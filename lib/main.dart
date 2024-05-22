import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_app/resources/auth_method.dart';
import 'package:get/get.dart';
import 'app_pages/splash_screen.dart';
import 'firebase_options.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //await Connectivity().checkConnectivity();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthMethod authMethod = AuthMethod();
  MyApp({super.key,});

  @override
  Widget build(BuildContext context) {
    //authMethod.listenForProjectChanges();
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}