import 'package:flutter/material.dart';

class CardHeaderWidget extends StatelessWidget {
  final String text;
  const CardHeaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "././assets/images/logo.png",
          height: 100,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
