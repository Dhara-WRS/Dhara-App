import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:epics_pj/cofig/colors.dart';

class SocialButton extends StatelessWidget {
  final onTap;
  final icon;
  const SocialButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1)),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: onTap,
        child: icon,
      ),
    );
  }
}
