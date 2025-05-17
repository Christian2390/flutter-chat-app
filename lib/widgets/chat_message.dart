import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    super.key,
    required this.texto,
    required this.uid,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        child: Container(child: uid == '123' ? _myMessage() : _notMyMessage()),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 6, bottom: 6, left: 48),
        decoration: BoxDecoration(
          color: Colors.brown.shade200,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.green.shade900,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(right: 48, bottom: 6, left: 6),
        decoration: BoxDecoration(
          color: Colors.amber.shade200,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.brown.shade500,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
