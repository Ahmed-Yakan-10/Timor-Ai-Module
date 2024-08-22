import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
    CustomCircleButton(
      {super.key, required this.buttonColor, required this.icon,required this.onPressed});

  final Color buttonColor;
  final Widget icon;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: buttonColor,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: Colors.white,
      ),
    );
  }
}
