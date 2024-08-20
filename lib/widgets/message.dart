import 'dart:io';

import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages(
      {super.key,
      required this.file,
      required this.sender,
      required this.hasImage,
      required this.text});

  final String text;
  final bool sender;
  final bool hasImage;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Row(
        mainAxisAlignment:
            sender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (file != null)
                Container(
                  height: 175,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    image: file != null
                        ? DecorationImage(image: FileImage(file!))
                        : null,
                  ),
                ),
              SizedBox(height: 3),
              Container(
                padding: EdgeInsets.all(5),
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  color:
                      sender ? Colors.grey[800] : Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
