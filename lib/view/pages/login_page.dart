import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/cofig/textstyles.dart';
import 'package:epics_pj/utils/services.dart';
import 'package:epics_pj/view/pages/home_page.dart';
import 'package:epics_pj/view/pages/pwd_resetpage.dart';
import 'package:epics_pj/view/pages/register_page.dart';
import 'package:epics_pj/view/pages/social_button.dart';
import 'package:epics_pj/view/widgets/buttons.dart';
import 'package:epics_pj/view/widgets/frostedBg.dart';
import 'package:epics_pj/view/widgets/input_container.dart';
import 'package:epics_pj/view/widgets/showMessage.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

void resetFeilds() {
  emailController.text = "";
  passController.text = "";
  emailC.text = "";
  nameC.text = "";
  phoneC.text = "";
  passC.text = "";
  rePassC.text = "";
}

var firebaseUser = FirebaseAuth.instance.currentUser;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscure = true;
  final _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    Future showLoading(text) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    color: AppColor.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(text),
                ],
              ),
            ),
          );
        },
      );
    }

    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FrostedBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            SizedBox(
              height: totalHeight * .08,
            ),
            const Text(
              "Hello Again!",
              textAlign: TextAlign.center,
              style: AppTextStyle.displayMedium,
            ),
            SizedBox(
              height: totalHeight * .01,
            ),
            const Text(
              "Welcome back you've\nbeen missed!",
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium,
            ),
            SizedBox(
              height: totalHeight * .05,
            ),
            InputContainer(
              child: TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter username',
                  labelStyle: AppTextStyle.labelStyle,
                  floatingLabelStyle: TextStyle(color: AppColor.primary),
                ),
              ),
            ),
            InputContainer(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: totalWidth * 0.65,
                    child: TextField(
                      controller: passController,
                      obscureText: obscure,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        labelStyle: AppTextStyle.labelStyle,
                        floatingLabelStyle: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        obscure = !obscure;
                      });
                    }),
                    child: Icon(
                      Icons.visibility_off_outlined,
                      size: 20,
                      color: (obscure) ? AppColor.darkGrey : AppColor.primary,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: totalHeight * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PwdResetPage()));
                  },
                  child: const Text(
                    "Recovery Password",
                    style: AppTextStyle.bodySmall,
                  ),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
            SizedBox(
              height: totalHeight * .025,
            ),
            AppButton(
              text: "Sign In",
              onTap: () {
                showLoading("Signing in");
                _firebaseService
                    .signIn(
                        email: emailController.text.toString(),
                        password: passController.text.toString())
                    .then((error) {
                  if (error == null) {
                    log('User Logging In...');
                    if (_firebaseService.user.emailVerified) {
                      log('Email Verified!');
                      log('Proceeding...');

                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      resetFeilds();
                    } else {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      resetFeilds();
                      //Ok Button
                      //Resend verification with on click methods
                    }
                  } else {
                    Navigator.pop(context);
                    showMessage(error.toString(), context); // Pop up required
                  }
                });
              },
            ),
            SizedBox(
              height: totalHeight * .02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: totalWidth * 0.3, child: const Divider()),
              const Text(
                "Or continue with",
                style: AppTextStyle.bodySmall,
              ),
              SizedBox(
                height: totalHeight * 0.12,
              ),
              SizedBox(width: totalWidth * 0.3, child: const Divider()),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SocialButton(
                  onTap: () async {
                    log("GOOLE LOGIN");
                    try {
                      await _firebaseService.signInWithGoogle();
                      // showLoading(context);
                      // if (!mounted) return;
                      // Navigator.pop(context);
                      // Navigator.pushReplacement(context,
                      // MaterialPageRoute(builder: (context) => HomePage()));
                    } catch (e) {
                      Navigator.pop(context);
                      if (e is FirebaseAuthException) {
                        showMessage(e.message!, context);
                      }
                    }
                  },
                  icon: Image.asset(
                    'assets/google_icon.png',
                    height: 25,
                  )),
              SocialButton(
                  onTap: () {},
                  icon: Image.asset(
                    'assets/apple_icon.png',
                    height: 28,
                  )),
              // SocialButton(
              //     onTap: () async {
              //       try {
              //         showLoading("loading");
              //         log("Login with Facebook");
              //         await _firebaseService.signInWithFacebook();
              //         if (!mounted) return;
              //         Navigator.pop(context);
              //         Navigator.pushReplacement(context,
              //             MaterialPageRoute(builder: (context) => HomePage()));
              //       } catch (e) {
              //         if (e is FirebaseAuthException) {
              //           showMessage(e.message!, context);
              //         }
              //       }
              //     },
              //     icon: const Icon(
              //       Icons.facebook,
              //       color: Colors.blue,
              //       size: 32,
              //     )),
            ]),
            SizedBox(
              height: totalHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member?", style: AppTextStyle.bodySmall),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      "Register Now",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ]),
        ),
      )),
    );
  }
}
