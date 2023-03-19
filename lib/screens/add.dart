import 'package:dimy/common/colors.dart';
import 'package:dimy/common/file_manage.dart';
import 'package:dimy/components/number_button.dart';
import 'package:dimy/components/usage_text.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';

class AddExpense extends StatefulWidget {
  final VoidCallback changeData;
  final VoidCallback goHome;
  const AddExpense({super.key, required this.changeData, required this.goHome});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  double expense = 0;
  String viewExpense = "0";
  double textSize = 50;
  List<bool> colorCategory = List.filled(categoryExpense.length, false);

  void updateViewExpense(String char) {
    setState(() {
      if (viewExpense == "0" && char != ".") {
        viewExpense = "";
      }
      if (viewExpense.contains(".") && char == ".") {
        return;
      }
      viewExpense += char;
      expense = double.parse(viewExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Text(date)
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    DateTime.now().toString().substring(0,10),
                    style: const TextStyle(color: Colors.white),
                  )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 10),
                  UsedText(
                    currency: "",
                    amount: viewExpense,
                    fontSize: textSize,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          viewExpense =
                              viewExpense.substring(0, viewExpense.length - 1);
                          if (viewExpense.isEmpty) {
                            viewExpense = "0";
                          }
                          textSize = lenMap[viewExpense.length]!;
                        });
                      },
                      icon: const Icon(Icons.backspace))
                ],
              )),
              SizedBox(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryExpense.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() {
                              colorCategory =
                                  List.filled(categoryExpense.length, false);
                              colorCategory[index] = true;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: colorCategory[index]
                                    ? colorMap[categoryExpense[index]]
                                    : Colors.black,
                                border:
                                    Border.all(color: Colors.white, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  categoryExpense[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      );
                    })),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberButton(
                          text: "1",
                          action: () {
                            updateViewExpense("1");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "2",
                          action: () {
                            updateViewExpense("2");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "3",
                          action: () {
                            updateViewExpense("3");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberButton(
                          text: "4",
                          action: () {
                            updateViewExpense("4");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "5",
                          action: () {
                            updateViewExpense("5");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "6",
                          action: () {
                            updateViewExpense("6");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberButton(
                          text: "7",
                          action: () {
                            updateViewExpense("7");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "8",
                          action: () {
                            updateViewExpense("8");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "9",
                          action: () {
                            updateViewExpense("9");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberButton(
                          text: ".",
                          action: () {
                            updateViewExpense(".");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      NumberButton(
                          text: "0",
                          action: () {
                            updateViewExpense("0");
                            setState(() {
                              textSize = lenMap[viewExpense.length]!;
                            });
                          },
                          isActive: viewExpense.length < 10),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                            onPressed:
                                ((viewExpense != "0" || viewExpense != "0.") && colorCategory.contains(true))
                                    ? () {
                                        String cat = "";
                                        for (int i = 0;
                                            i < colorCategory.length;
                                            i++) {
                                          if (colorCategory[i] == true) {
                                            cat = categoryExpense[i];
                                            break;
                                          }
                                        }
                                        
                                        String userData =
                                            "\"${DateTime.now().toString().substring(0, 10)}\",\"$cat\",\"$viewExpense\",\"${DateTime.now().toString().substring(11,16)}\"";
                                        writeData(userData).then((value) {
                                          widget.changeData();
                                          widget.goHome();
                                        });
                                      }
                                    : null,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 17),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
