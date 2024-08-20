import 'package:flutter/material.dart';
import 'package:timor_ai/widgets/custom_text_field.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ListView()),
        Container(
          decoration: BoxDecoration(
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_photo_alternate_outlined,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 220,
                child: CustomTextField(),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mic_none_outlined,
                    color: Colors.white,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
