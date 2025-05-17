import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];
  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        title: Center(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.amber.shade200,
                maxRadius: 16,
                child: Text('Te', style: TextStyle(fontSize: 12)),
              ),
              SizedBox(height: 3),
              Text(
                'Maria Alv',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
        elevation: 2,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            Divider(height: 2),
            //TODO: Caja de texto
            Container(color: Colors.grey.shade400, child: _imputChat()),
          ],
        ),
      ),
    );
  }

  Widget _imputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar Mensaje',
                ),
                focusNode: _focusNode,
              ),
            ),
            //Botón de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              child:
                  Platform.isIOS
                      ? CupertinoButton(
                        onPressed:
                            _estaEscribiendo
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                        child: Text('Enviar'),
                      )
                      : Container(
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.amber.shade200),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(Icons.send_outlined),
                            onPressed:
                                _estaEscribiendo
                                    ? () => _handleSubmit(
                                      _textController.text.trim(),
                                    )
                                    : null,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }
}
