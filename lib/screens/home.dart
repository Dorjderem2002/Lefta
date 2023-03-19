import 'package:dimy/components/item_row.dart';
import 'package:dimy/components/usage_text.dart';
import 'package:dimy/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final Map<String,String> total;
  final String allTimeExpense;
  final VoidCallback handleExpense;
  const HomeScreen({super.key, required this.total, required this.allTimeExpense, required this.handleExpense});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExpenseController expenseController = Get.put(ExpenseController());
  final List<DropdownMenuItem> timeOptions = [
    const DropdownMenuItem(
      value: "Today",
      child: Text("Today"),
    ),
    const DropdownMenuItem(
      value: "This week",
      child: Text("This week"),
    ),
    const DropdownMenuItem(
      value: "This month",
      child: Text("This month"),
    ),
    const DropdownMenuItem(
      value: "This year",
      child: Text("This year"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Spent"),
              const SizedBox(
                width: 10,
              ),
              DropdownButton(
                  value: expenseController.durationExpense,
                  items: timeOptions,
                  onChanged: (stext) {
                    setState(() {
                      expenseController.durationExpense = stext;
                      widget.handleExpense();
                    });
                  }),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 120,
              child: Center(child: UsedText(currency: "", amount: widget.allTimeExpense, fontSize: 50,))),
          for (int i = 0; i < expenseController.expenseData.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: ItemRow(date: expenseController.expenseData[i][0], data: expenseController.expenseData[i], total: widget.total[expenseController.expenseData[i][0]]!,),
            ),
        ],
      ),
    );
  }
}
