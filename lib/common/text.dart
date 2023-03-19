import 'package:dimy/common/colors.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  const MyText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(color: MyColors.gray),);
  }
}