import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
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
  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  bool isListening = false;
  bool isInitialized = false;
  double voiceLevel = 25.0;
  String responseText = '';
  int step = 0;
  double endHe = 70.0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    micCheck();
    Gemini.init(apiKey: kApi);
    initTTs();
  }

  micCheck() async {
    bool mic = await speechToText.initialize();

    if (mic) {
      setState(() => isInitialized = true);
    } else {
      showSnackBar(
        'Microphone access is required to use this feature. Please enable it in your settings.',
        Colors.red,
      );
      Future.delayed(Duration(seconds: 5), micCheck);
    }
  }

  void getVoice() {
    if (!isInitialized) {
      showSnackBar(
        'Speech recognition is not initialized. Please try again later.',
        Colors.red,
      );
      return;
    }

    if (!isListening) {
      setState(() => isListening = true);
      speechToText.listen(
        listenFor: Duration(minutes: 10),
        partialResults: false,
        onResult: (result) {
          getChatText(result.recognizedWords);
          setState(() => isListening = false);
        },
        onSoundLevelChange: (level) {
          setState(() => voiceLevel = max(30, level * 5));
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

  void getChatText(String text) {
    setState(() => step = 1);

    Gemini.instance.text(text).then(
          (value) {
        String output = value?.output.toString() ?? '';
        setState(() {
          step = 2;
          responseText = output;
        });
        flutterTts.speak(output);
      },
    );
  }

  initTTs() async {
    await flutterTts.awaitSpeakCompletion(true);
    flutterTts.setStartHandler(() {
      startTimer();
    });
    flutterTts.setCompletionHandler(() {
      timer?.cancel();
      setState(() {
        endHe = 70.0;
        step = 0;
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        endHe = endHe == 70.0 ? 100.0 : 70.0;
      });
    });
  }

  void cancelSpeech() {
    flutterTts.stop();
    setState(() {
      step = 0;
      isListening = false;
    });
  }

  void showSnackBar(String message, Color backgroundColor) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        backgroundColor: backgroundColor,
        message: message,
      ),
    );
  }

  Widget buildAvatarOrAnimation() {
    if (step == 0) {
      return Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 125,
        ),
      );
    } else if (step == 1) {
      return Center(
        child: Lottie.asset(
          'assets/images/Animation.json',
          repeat: true,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          double multiplier = [1.1, 1.25, 1.5, 1.4][index];
          return Padding(
            padding: const EdgeInsets.only(right: 2),
            child: AnimatedContainer(
              height: endHe * multiplier,
              width: 40,
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }),
      );
    }
  }

  Widget buildStatusText() {
    String status = '';
    if (step == 1) {
      status = 'Loading...';
    } else if (isListening) {
      status = 'Listening...';
    } else {
      status = 'Tap to start';
    }

    return Text(
      status,
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
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
              showSnackBar(
                'Speak with AI and ask it about anything.',
                Colors.black,
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
          buildAvatarOrAnimation(),
          SizedBox(
            height: (step == 0)
                ? 100
                : step == 1
                ? 10
                : 220,
          ),
          buildStatusText(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomCircleButton(
            onPressed: getVoice,
            icon: (step == 2)
                ? Icon(Icons.square)
                : isListening
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
            buttonColor: Color(0xff494C4C),
          ),
          if (step == 0)
            Row(
              children: [
                Icon(Icons.mic, size: 30),
                AnimatedSpeechContainer(height: voiceLevel),
              ],
            ),
          if (step == 1)
            Icon(
              Icons.mic,
              size: 30,
              color: Colors.grey,
            ),
          if (step == 2)
            Icon(
              Icons.mic,
              size: 30,
              color: Colors.grey,
            ),
          CustomCircleButton(
            onPressed: cancelSpeech,
            icon: Icon(Icons.close),
            buttonColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
