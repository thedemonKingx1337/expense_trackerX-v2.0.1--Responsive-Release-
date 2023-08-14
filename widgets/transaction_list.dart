import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TransactionList_Widg extends StatelessWidget {
  final List transactionsPassed;
  final Function deleteTransaction_PassedPointer;
  TransactionList_Widg(
      this.transactionsPassed, this.deleteTransaction_PassedPointer);

  @override
  Widget build(BuildContext context) {
    return transactionsPassed.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: constraints.maxHeight * .7,
                width: constraints.maxWidth * .7,
                child: Center(
                  child: FittedBox(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(width: 10, color: Colors.white),
                              right: BorderSide(width: 10, color: Colors.white),
                              top: BorderSide(width: 10, color: Colors.white),
                              bottom:
                                  BorderSide(width: 30, color: Colors.white),
                            ),
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Lottie.asset(
                            "lib/expense_tracker/assets/animation/animation_lkxoe05v.json",
                            height: 300,
                            width: 300,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: Text("No data",
                              style: GoogleFonts.shadowsIntoLight(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: transactionsPassed.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(6),
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    elevation: 10,
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: FittedBox(
                                child: Row(
                              children: [
                                Text(
                                  "₹   ",
                                  style: GoogleFonts.odibeeSans(
                                      textStyle: TextStyle(
                                    color: Colors.green[100],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                                ),
                                Text(
                                  "${transactionsPassed[index].amount.toStringAsFixed(2)}",
                                  style: GoogleFonts.odibeeSans(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2)),
                                ),
                              ],
                            )),
                          )),
                      title: Text(
                        transactionsPassed[index].name,
                        style: GoogleFonts.koulen(
                            fontSize: 20,
                            letterSpacing: 1,
                            color: Colors.redAccent),
                      ),
                      subtitle: Text(
                        "${DateFormat('EEE, d/M/y').format(transactionsPassed[index].created)}",
                        style: GoogleFonts.smoochSans(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400]),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            deleteTransaction_PassedPointer(
                                transactionsPassed[index].id);
                          },
                          icon: Icon(
                            FontAwesomeIcons.trashCan,
                            color: Colors.blueGrey[200],
                          )),
                    ),
                  ));
            },
          );
  }
}
