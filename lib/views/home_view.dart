import 'package:flutter/material.dart';
import 'package:timor_ai/constants.dart';
import 'package:timor_ai/views/chat_bot_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Timor',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(width: 2),
            Container(
              height: 40,
              child: Image.asset(
                kIcon,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: ChatBotView(),
    );
  }
}
