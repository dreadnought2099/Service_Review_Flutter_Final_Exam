import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final TextStyle textStyle; // Add this property

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textStyle, // Initialize it
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        ),
      ),
      child: Text(
        text,
        style: textStyle, // Apply the text style here
      ),
    );
  }
}
