import 'package:flutter/material.dart';

class BotonIngres extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonIngres({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed;
      },
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black54,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Container(
        width: double.infinity,
        child: Center(child: Text(text, style: TextStyle(fontSize: 18))),
      ),
    );
  }
}
