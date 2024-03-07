import 'dart:developer';

import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/cofig/textstyles.dart';
import 'package:epics_pj/utils/services.dart';
import 'package:epics_pj/view/pages/onboarding_page.dart';
import 'package:epics_pj/view/pages/report_water_problem_page.dart';
import 'package:epics_pj/view/pages/view_reported_problems_page.dart';
import 'package:epics_pj/view/widgets/buttons.dart';
import 'package:epics_pj/view/widgets/frostedBg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
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

    var user = _firebaseService.getAuth().currentUser;
    return Scaffold(
      body: FrostedBackground(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              left: -180,
              child: SvgPicture.asset(
                "assets/Frame.svg",
                color: AppColor.primary.withOpacity(0.1),
                height: 300,
              ),
            ),
            Positioned(
              bottom: -10,
              right: -100,
              child: SvgPicture.asset(
                "assets/Frame1.svg",
                color: AppColor.primary.withOpacity(0.15),
                height: 200,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                user!.photoURL.toString(),
                                height: 70,
                                width: 70,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              "Hey! ${user.displayName}",
                              textAlign: TextAlign.start,
                              style: AppTextStyle.displayLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                        text: "Report Water Problem",
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportWaterProblemPage()));
                        }),
                    AppButton(
                        text: "View Reported Problem",
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WaterProblemsPage()));
                        }),
                    TextButton(
                        child: Text("Logout"),
                        onPressed: () async {
                          showLoading("Logging out");
                          try {
                            await _firebaseService.signOut().then((value) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OnBoardingPage()));
                            });
                          } catch (e) {
                            log(e.toString());
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
