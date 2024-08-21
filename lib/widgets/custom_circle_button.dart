import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton({super.key, required this.buttonColor, required this.icon});

  final Color buttonColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,backgroundColor: buttonColor,
      child: Icon(icon,color: Colors.white,),
    );
  }
}
