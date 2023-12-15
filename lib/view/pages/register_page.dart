import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/cofig/textstyles.dart';
import 'package:epics_pj/utils/services.dart';
import 'package:epics_pj/view/pages/login_page.dart';
import 'package:epics_pj/view/pages/onboarding_page.dart';
import 'package:epics_pj/view/widgets/buttons.dart';
import 'package:epics_pj/view/widgets/frostedBg.dart';
import 'package:epics_pj/view/widgets/input_container.dart';
import 'package:epics_pj/view/widgets/showMessage.dart';

TextEditingController emailC = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController rePassC = TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

    return Scaffold(
        body: FrostedBackground(
            child: SafeArea(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Sign Up",
                style: AppTextStyle.displayLarge,
              ),
              const Text(
                "Let's innovate together",
                style: AppTextStyle.displayMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              InputContainer(
                child: TextField(
                  controller: nameC,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Name',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: emailC,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: phoneC,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Phone',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: passC,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: rePassC,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Re-enter Password',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              AppButton(
                  text: "Register",
                  onTap: () async {
                    if (emailC.text.toString() != "" &&
                        passC.text.toString() != "" &&
                        nameC.text.toString() != "" &&
                        phoneC.text.toString() != "" &&
                        rePassC.text.toString() != "") {
                      if (phoneC.text.toString().length < 10) {
                        if (phoneC.text.toString().isEmpty) {
                          log('Are you sure you want to continue without phone number');
                          return;
                        } else {
                          log('Please enter a correct phone number');
                        }
                      }
                      if (passC.text.toString() == rePassC.text.toString()) {
                        showLoading("Registering");
                        _firebaseService
                            .signUp(
                                email: emailC.text.toString(),
                                password: passC.text.toString())
                            .then((error) {
                          if (error == null) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnBoardingPage()));
                            resetFeilds();
                            showMessage(
                                "Verification e-mail has been sent to given e-mail address please verify and Sign in using your e-mail and password.",
                                context);
                          } else {
                            Navigator.pop(context);
                            log('Error : $error');
                            showMessage(error.toString(), context);
                          }
                        });
                      } else {
                        log("Passwords don't match!");
                        showMessage("Passwords don't match!", context);
                      }
                    } else {
                      log('Please fill all fields to continue');
                      showMessage(
                          'Please fill all fields to continue', context);
                    }
                  })
            ],
          )),
    )));
  }
}
