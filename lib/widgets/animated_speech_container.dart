import 'package:flutter/material.dart';

class AnimatedSpeechContainer extends StatelessWidget {
  const AnimatedSpeechContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: AnimatedContainer(
            height: height==25.0?25.5:height*1.1,
            width: 20,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: AnimatedContainer(
            height: height==25.0?25.5:height*1.2,
            width: 20,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: AnimatedContainer(
            height: height==25.0?25.5:height*1.5,
            width: 20,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: AnimatedContainer(
            height: height==25.0?25.5:height*1.2,
            width: 20,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }
}
