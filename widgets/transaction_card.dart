import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class transactionCard extends StatefulWidget {
  final addTransactionPassedPointer;
  transactionCard(this.addTransactionPassedPointer);

  @override
  State<transactionCard> createState() => _transactionCardState();
}

class _transactionCardState extends State<transactionCard> {
  final nameIn = TextEditingController();

  final amountIn = TextEditingController();

  DateTime? pickedDate_temp;

  void submitDataFunction() {
    if (amountIn.text.isEmpty) {
      return;
    }
    final inTitle = nameIn.text, inAmount = double.parse(amountIn.text);
    if (inTitle.isEmpty || inAmount <= 0 || pickedDate_temp == null) {
      return;
    }
    widget.addTransactionPassedPointer(inTitle, inAmount, pickedDate_temp);
    Navigator.of(context).pop();
  }

  void datePicker_Fn() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          pickedDate_temp = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          child: Padding(
        padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: nameIn,
              decoration: InputDecoration(labelText: "Product Name"),
              onSubmitted: (value) => submitDataFunction(),
            ),
            TextField(
              controller: amountIn,
              decoration: InputDecoration(hintText: "Amount "),
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submitDataFunction(),
            ),
            SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(pickedDate_temp == null
                  ? "No date picked"
                  : DateFormat("dd/MM/yy").format(pickedDate_temp!)),
              IconButton(
                onPressed: datePicker_Fn,
                icon: Icon(FontAwesomeIcons.calendar),
                color: Colors.deepOrange,
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 5),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepOrange),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(5))),
                  onPressed: submitDataFunction,
                  child: Text("Submit")),
            )
          ],
        ),
      )),
    );
  }
}
