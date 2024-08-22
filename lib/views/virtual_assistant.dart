import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:timor_ai/constants.dart';
import 'package:timor_ai/widgets/animated_speech_container.dart';
import 'package:timor_ai/widgets/custom_circle_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VirtualAssistant extends StatefulWidget {
  const VirtualAssistant({super.key});

  @override
  State<VirtualAssistant> createState() => _VirtualAssistantState();
}

class _VirtualAssistantState extends State<VirtualAssistant> {
  SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  bool isInitialized = false;
  var voiceLevel = 30.0;

  Future<void> micCheck() async {
    bool mic = await speechToText.initialize();

    if (mic) {
      setState(() {
        isInitialized = true;
      });
    } else {
      // Show a message to the user and try to initialize again after a delay
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          backgroundColor: Colors.red,
          message:
              'Microphone access is required to use this feature. Please enable it in your settings.',
        ),
      );
      // Retry initialization after a delay
      Future.delayed(Duration(seconds: 5), micCheck);
    }
  }

  void getVoice() {
    if (!isInitialized) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          backgroundColor: Colors.red,
          message:
              'Speech recognition is not initialized. Please try again later.',
        ),
      );
      return;
    }

    if (!isListening) {
      setState(() {
        isListening = true;
      });
      speechToText.listen(
        partialResults: false,
        listenFor: Duration(minutes: 10),
        onResult: (result) {
          print(result);
          setState(() {
            isListening = false;
          });
        },
        onSoundLevelChange: (level) {
          setState(() {
            voiceLevel = max(30, level * 5);
          });
        },
      );
    } else {
      setState(() {
        isListening = false;
        voiceLevel = 30.0;
      });
      speechToText.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    micCheck();
    Gemini.init(apiKey: kApi);
  }

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
                  message: 'Speak with AI and ask it about anything.',
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
            isListening ? 'Listening...' : 'Tap to start',
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
            onPressed: () {
              getVoice();
            },
            icon: isListening ? Icon(Icons.pause) : Icon(Icons.play_arrow),
            buttonColor: Color(0xff494C4C),
          ),
          const SizedBox(width: 25),
          AnimatedSpeechContainer(
            height: voiceLevel,
          ),
          const SizedBox(width: 25),
          CustomCircleButton(
            onPressed: () {},
            icon: Icon(Icons.close),
            buttonColor: Colors.red,
          ),
          const SizedBox(width: 25),
        ],
      ),
    );
  }
}
