import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IconCard extends StatelessWidget {
  final Function() fun;
  final FaIcon icon;
  const IconCard({super.key, required this.fun, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation:10,
      borderRadius: BorderRadius.circular(20.0),
      child:GestureDetector(
        onTap: fun,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
            ),
          child:Center(
            child: icon,
          )
        ),
      )
    );
  }
}
