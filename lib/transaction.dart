import 'package:flutter/material.dart';

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  MyTransaction({
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.yellow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black87),
                    child: Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(transactionName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      )),
                ],
              ),
              Text(
                (expenseOrIncome == 'expense' ? '-' : '+') + '\$' + money,
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color:
                  expenseOrIncome == 'expense' ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
