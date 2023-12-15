import 'dart:developer';
import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/firebase_options.dart';
import 'package:epics_pj/view/pages/home_page.dart';
import 'package:epics_pj/view/pages/onboarding_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLogin = false;
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      User? firebaseUserr = FirebaseAuth.instance.currentUser;
      var user = firebaseUserr ?? null;
      print(user);
      if (user != null) {
        _isLogin = true;
      }
    } catch (e) {
      log(e.toString());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login/Sign up',
      theme: ThemeData(
          primaryColor: AppColor.primary,
          backgroundColor: AppColor.background,
          fontFamily: "Poppins"),
      home: (_isLogin) ? HomePage() : const OnBoardingPage(),
    );
  }
}
