import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  final bool isActive;
  const NumberButton({super.key, required this.action, required this.text, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
      onPressed: isActive ? action : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    ));
  }
}
