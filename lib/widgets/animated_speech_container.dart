import 'package:flutter/material.dart';

class AnimatedSpeechContainer extends StatelessWidget {
  const AnimatedSpeechContainer({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.mic,
          size: 30,
        ),
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: AnimatedContainer(
            height: height==30.0?height:height*1.2,
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
            height: height==30.0?height:height*1.44,
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
            height: height==30.0?height:height*1.75,
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
            height: height==30.0?height:height*1.55,
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
