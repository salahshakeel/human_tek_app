import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onPressed;
  final IconData? prefix_icon;
  final TextEditingController? controller;
  const TextFeildWidget(
      {super.key,
      required this.hintText,
      this.prefix_icon,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.controller,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0.2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText ?? false,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onPressed,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusColor: Colors.grey,
              prefixIcon: prefix_icon == null ? null : Icon(prefix_icon),
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
  }
}
