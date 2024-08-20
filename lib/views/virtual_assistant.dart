import 'package:flutter/material.dart';
import 'package:timor_ai/constants.dart';

class VirtualAssistant extends StatelessWidget {
  const VirtualAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Virtual Assistant',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
