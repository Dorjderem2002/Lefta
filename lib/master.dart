import 'package:csv/csv.dart';
import 'package:dimy/common/file_manage.dart';
import 'package:dimy/expense_controller.dart';
import 'package:dimy/screens/add.dart';
import 'package:dimy/screens/charts.dart';
import 'package:dimy/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/colors.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  PageController pageController = PageController();
  int _selectedIndex = 0;
  ExpenseController expenseController = Get.put(ExpenseController());
  Map<String, String> total = {};
  String allTimeExpense = "";

  @override
  void initState() {
    super.initState();
    changeData();
  }

  void goHome() {
    setState(() {
      _selectedIndex = 0;
    });
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void changeData() {
    total.clear();
    allTimeExpense = "";
    readJson().then((value) {
      setState(() {
        expenseController.expenseData = value;
        allTimeExpense = handleExpense();
      });
    });
  }

  void changeExpense()
  {
    setState(() {
      allTimeExpense = handleExpense();
    });
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  Future<List<List<String>>> readJson() async {
    //final String response = await rootBundle.loadString("assets/dummy.csv");
    final String response = await readData();
    List<List<dynamic>> rowsAsListOfValues =
        const CsvToListConverter().convert(response);
    List<List<String>> result = [];
    List<String> temp = [];
    double sum = 0;
    if (response.isNotEmpty) {
      for (int i = 0; i < rowsAsListOfValues[0].length; i++) {
        if (rowsAsListOfValues[0][i].toString() == "CRLF") {
          temp[0] = temp[0].trim();
          result.add(temp);
          total[temp[0]] = sum.toStringAsFixed(2);
          sum = 0;
          temp = [];
        } else {
          temp.add(rowsAsListOfValues[0][i].toString());
          if (isNumeric(rowsAsListOfValues[0][i])) {
            sum += double.parse(double.parse(rowsAsListOfValues[0][i]).toStringAsFixed(2));
          }
        }
      }
    }
    return result;
  }

  String handleExpense() {
    String tod = DateTime.now().toUtc().toString().substring(0, 10);
    if (expenseController.durationExpense == "Today" &&
        total.containsKey(tod)) {
      return total[tod]!;
    } else if (expenseController.durationExpense == "This week") {
      double tSum = 0;
      int weekNum = DateTime.now().weekday;
      int index = 0;
      while(weekNum - index > 0) {
        String tDay = DateTime.now().subtract(Duration(days: index)).toString().substring(0,10);
        if(total.containsKey(tDay))
        {
          tSum += double.parse(total[tDay]!);
        }
        index++;
      }
      return tSum.toStringAsFixed(2);
    } else if (expenseController.durationExpense == "This month") {
      double tSum = 0;
      int index = 0;
      DateTime t = DateTime.now().subtract(Duration(days: index));
      while(t.toString().substring(8,10) != "01") {
        String tDay = DateTime.now().subtract(Duration(days: index)).toString().substring(0,10);
        if(total.containsKey(tDay))
        {
          tSum += double.parse(total[tDay]!);
        }
        index++;
        t = DateTime.now().toUtc().subtract(Duration(days: index));
      }
      String tDay = DateTime.now().toUtc().subtract(Duration(days: index)).toString().substring(0,10);
      if(total.containsKey(tDay))
      {
        tSum += double.parse(total[tDay]!);
      }
      return tSum.toStringAsFixed(2);
    } else {
      double tSum = 0;
      int index = 0;
      DateTime t = DateTime.now().toUtc().subtract(Duration(days: index));
      while(t.toString().substring(5,10) != "01-01") {
        String tDay = DateTime.now().toUtc().subtract(Duration(days: index)).toString().substring(0,10);
        if(total.containsKey(tDay))
        {
          tSum += double.parse(total[tDay]!);
        }
        index++;
        t = DateTime.now().toUtc().subtract(Duration(days: index));
      }
      String tDay = DateTime.now().toUtc().subtract(Duration(days: index)).toString().substring(0,10);
      if(total.containsKey(tDay))
      {
        tSum += double.parse(total[tDay]!);
      }
      return tSum.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        height: 60,
        backgroundColor: MyColors.backgroundColor,
        surfaceTintColor: MyColors.backgroundColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
          pageController.jumpToPage(_selectedIndex);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.payments), label: ''),
          NavigationDestination(icon: Icon(Icons.add), label: ''),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: ''),
        ],
      ),
      body: SafeArea(
          child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(
            total: total,
            allTimeExpense: allTimeExpense,
            handleExpense: changeExpense,
          ),
          AddExpense(changeData: changeData, goHome: goHome),
          ChartScreen(total: total,),
        ],
      )),
    );
  }
}
