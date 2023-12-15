import 'package:flutter/material.dart';
import 'package:epics_pj/cofig/colors.dart';
import 'package:epics_pj/cofig/dimens.dart';
import 'package:epics_pj/cofig/textstyles.dart';

class AppButton extends StatelessWidget {
  final text;
  final onTap;
  const AppButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColor.primary.withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 20,
            offset: const Offset(0, 20))
      ]),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: MaterialButton(
        onPressed: onTap,
        elevation: 1,
        color: AppColor.primary,
        height: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
        ),
        child: Text(
          text,
          style: AppTextStyle.buttonLight,
        ),
      ),
    );
  }
}
