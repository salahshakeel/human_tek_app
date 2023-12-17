import 'package:flutter/material.dart';

class SuccessAlertBoxWidget extends StatelessWidget {
  final String message;
  const SuccessAlertBoxWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: AlertDialog(
        title: Icon(Icons.check, size: 30, color: Colors.green),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}