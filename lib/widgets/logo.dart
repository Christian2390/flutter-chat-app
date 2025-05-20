import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({super.key, required this.titulo});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image(image: AssetImage('assets/tag-logo-a.png')),
            ),
            SizedBox(height: 2),
            Text(titulo, style: TextStyle(fontSize: 38)),
          ],
        ),
      ),
    );
  }
}
