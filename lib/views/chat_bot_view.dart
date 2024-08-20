import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timor_ai/constants.dart';
import 'package:timor_ai/views/virtual_assistant.dart';
import 'package:timor_ai/widgets/custom_text_field.dart';
import 'package:timor_ai/widgets/message.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  File? file;
  TextEditingController? controller = TextEditingController();
  List messages = [];

  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: kApi);
  }

  pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
    }
  }

  add() {
    if (controller!.text.isNotEmpty) {
      if (file != null) {
        setState(() {
          messages.add({
            "text": controller!.text,
            "file": file,
            "sender": true,
            "hasImage": true,
          });
        });
        Gemini gemini = Gemini.instance;
        gemini.textAndImage(
          text: controller!.text,
          images: [file!.readAsBytesSync()],
        ).then((value) {
          setState(() {
            messages.add({
              "text": value!.content!.parts!.last.text,
              "file": null,
              "sender": false,
              "hasImage": false,
            });
          });
        });
        file = null;
      } else {
        setState(() {
          messages.add({
            "text": controller!.text,
            "file": null,
            "sender": true,
            "hasImage": false,
          });
        });
        Gemini gemini = Gemini.instance;
        gemini.text(controller!.text).then((value) {
          value!.output;
          setState(() {
            messages.add({
              "text": value.output,
              "file": null,
              "sender": false,
              "hasImage": false,
            });
          });
        });
      }
    }
    setState(() {
      controller!.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Messages(
                  file: messages[index]["file"],
                  sender: messages[index]["sender"],
                  hasImage: messages[index]["hasImage"],
                  text: messages[index]["text"],
                );
              },
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          height: 70,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    pickImage();
                  });
                },
                icon: const Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 200,
                child: CustomTextField(
                  controller: controller,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      add();
                      controller!.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VirtualAssistant(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.assistant,
                    color: Colors.white,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
