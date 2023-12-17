import 'package:flutter/material.dart';

class ErrorAlertBoxWidget extends StatelessWidget {
  final String message;
  const ErrorAlertBoxWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: AlertDialog(
        title: Icon(Icons.error, size: 30, color: Colors.red),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
