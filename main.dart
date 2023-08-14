import 'package:flutter/material.dart';
import 'package:project_march/expense_tracker/widgets/transaction_card.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(MaterialApp(home: Home(), theme: ThemeData.dark()));
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool showChart = false;
  bool showChart1 = true;
  final List<Transaction> userTransaction = [];

  List<Transaction> get recentTransaction_dumb {
    return userTransaction.where((transaction_iterated_element) {
      return transaction_iterated_element.created
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(
      String passedTitle, double passedAmount, DateTime chosenDate) {
    final newTransactionAdded = Transaction(
        id: DateTime.now().toString(),
        name: passedTitle,
        amount: passedAmount,
        created: chosenDate);

    setState(() {
      userTransaction.add(newTransactionAdded);
    });
  }

  void AddNewTransaction_BottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (bcontext) => transactionCard(addNewTransaction));
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction
          .removeWhere((iterated_element) => iterated_element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar_storage = AppBar(
      centerTitle: true,
      title: Text("Expense TrackerX"),
    );
    final transaction_List_Widget_Store = Container(
        height: (MediaQuery.of(context).size.height -
                appBar_storage.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            .7,
        child: TransactionList_Widg(userTransaction, deleteTransaction));
    return Scaffold(
      appBar: appBar_storage,
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (isLandScape)
            Switch(
              value: showChart,
              onChanged: (value) {
                setState(() {
                  showChart = value;
                });
              },
            ),
          if (!isLandScape)
            Column(
              children: [
                Switch(
                  value: showChart1,
                  onChanged: (value) {
                    setState(() {
                      showChart1 = !showChart1;
                    });
                  },
                ),
                if (showChart1)
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar_storage.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          .3,
                      child: Chart(recentTransaction_dumb)),
              ],
            ),
          if (!isLandScape) transaction_List_Widget_Store,
          if (isLandScape)
            showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar_storage.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        .7,
                    child: Chart(recentTransaction_dumb))
                : transaction_List_Widget_Store
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).highlightColor,
          onPressed: () {
            return AddNewTransaction_BottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
