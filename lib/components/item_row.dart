import 'package:dimy/common/colors.dart';
import 'package:dimy/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/text.dart';

class ItemRow extends StatelessWidget {
  final String date;
  final List<String> data;
  final String total;
  const ItemRow(
      {super.key, required this.date, required this.data, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [MyText(text: date), MyText(text: "HK\$$total")],
        ),
        const Divider(
          color: MyColors.gray,
        ),
        for (int i = 1; i < data.length; i += 3)
          Item(
            price: data[i + 1],
            category: data[i],
            time: data[i + 2],
          ),
      ],
    );
  }
}

class Item extends StatefulWidget {
  final String category;
  final String price;
  final String time;
  const Item(
      {super.key,
      required this.category,
      required this.price,
      required this.time});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  double itemScale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.heavyImpact();
        setState(() {
          itemScale = 1.1;
        });
      },
      child: AnimatedScale(
        scale: itemScale,
        duration: const Duration(milliseconds: 100),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: colorMap[widget.category],
                ),
                child: Center(
                    child: Text(
                  emojiMap[widget.category]!,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  Text(widget.time,
                      style: const TextStyle(
                          fontSize: 10, color: MyColors.gray)),
                ],
              ),
              Expanded(
                  child: Container(
                color: Colors.transparent,
                height: 35,
              )),
              Text(
                "HK\$${widget.price}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
