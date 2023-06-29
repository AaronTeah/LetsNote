import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom:0,
      right:0,
      child:GestureDetector(
      onTap: function,
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          color: Colors.yellow[500],
          size: 35,
        ),

        // Center(
        //   child: Text(
        //     '+',
        //     style: TextStyle(color: Colors.yellow, fontSize: 25),
        //   ),
        // ),
      ),
      ),
    );
  }
}
