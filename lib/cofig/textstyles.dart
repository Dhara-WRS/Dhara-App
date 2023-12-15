import 'package:flutter/material.dart';
import 'package:epics_pj/cofig/colors.dart';

class AppTextStyle {
  static const buttonLight = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColor.white,
  );
  static const buttonDark = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );
  static const displayLarge = TextStyle(
    fontSize: 16,
    color: AppColor.black,
    fontWeight: FontWeight.bold,
  );
  static const displayMedium = TextStyle(
      fontSize: 24,
      color: AppColor.black,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.9);
  static const displaySmall = TextStyle(
    fontSize: 14,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    color: AppColor.darkGrey,
    fontWeight: FontWeight.w600,
  );
  static const dialogSmall = TextStyle(
    fontSize: 14,
    color: AppColor.darkGrey,
    fontWeight: FontWeight.w500,
  );
  static const dialogTitle = TextStyle(
    fontSize: 16,
    color: AppColor.darkGrey,
    fontWeight: FontWeight.w600,
  );
  static const labelStyle = TextStyle(
    fontSize: 13,
    color: AppColor.grey,
    fontWeight: FontWeight.w500,
  );
}
