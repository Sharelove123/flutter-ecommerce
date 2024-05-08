import 'package:flutter/material.dart';

class ModalView extends StatelessWidget {
  const ModalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }
}