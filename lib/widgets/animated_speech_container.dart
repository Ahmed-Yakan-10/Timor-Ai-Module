import 'package:flutter/material.dart';

class AnimatedSpeechContainer extends StatelessWidget {
  const AnimatedSpeechContainer({super.key});

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
            height: 30,
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
            height: 30,
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
            height: 30,
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
            height: 30,
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
