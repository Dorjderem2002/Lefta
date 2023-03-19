import 'package:dimy/common/colors.dart';
import 'package:flutter/material.dart';

class UsedText extends StatelessWidget {
  final String currency;
  final String amount;
  final double fontSize;
  const UsedText({super.key, required this.currency, required this.amount, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$currency\$',
          style: TextStyle(
            fontSize: fontSize-10,
            color: MyColors.gray,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          amount,
          style: TextStyle(
            height: 1,
            fontSize: fontSize,
          ),
        )
      ],
    );
  }
}

