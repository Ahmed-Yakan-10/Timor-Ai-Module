import 'package:flutter/material.dart';
import 'package:timor_ai/constants.dart';
import 'package:timor_ai/views/home_view.dart';

void main() {
  runApp(const TimorAi());
}

class TimorAi extends StatelessWidget {
  const TimorAi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: kFont,
      ),
      home: const HomeView(),
    );
  }
}
