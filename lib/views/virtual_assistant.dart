import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:timor_ai/constants.dart';
import 'package:timor_ai/widgets/animated_speech_container.dart';
import 'package:timor_ai/widgets/custom_circle_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
        actions: [
          IconButton(
            onPressed: () {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.info(
                  backgroundColor: Colors.black,
                  message:
                  'Speak with Ai and ask it about any thing',
                ),
              );
            },
            icon: Icon(
              Icons.info_outline_rounded,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 125,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Tap to start',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 25),
          CustomCircleButton(
            icon: Icons.play_arrow,
            buttonColor: Color(0xff494C4C),
          ),
          const SizedBox(width: 25),
          AnimatedSpeechContainer(),
          const SizedBox(width: 25),
          CustomCircleButton(
            icon: Icons.close,
            buttonColor: Colors.red,
          ),
          const SizedBox(width: 25),
        ],
      ),
    );
  }
}
