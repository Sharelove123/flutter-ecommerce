
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String data;
  final Function() fun;
  CustomButtom({super.key, required this.data, required this.fun});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(40),
      child: GestureDetector(
        onTap: fun,
        child: Container(
          height: 40,
          width:140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.blueAccent
            ),
          child:Center(
            child: Text(
              data,
              style: TextStyle(color: Colors.white),
              ),
          ),
        ),
      ),
    );
  }
}