import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:chat_app/widgets/custom_imput.dart';
import 'package:chat_app/widgets/boton_ingres.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(titulo: 'Messenger'),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes una cuenta?',
                  subTitulo: 'Crea una ahora!!',
                ),
                Text(
                  'Términos y condiciones de uso!',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authSevice = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        children: <Widget>[
          CustomImput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          CustomImput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          BotonIngres(
            text: 'INGRESAR',
            onPressed:
                authSevice.autenticando
                    ? null
                    : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authSevice.login(
                        emailCtrl.text.trim(),
                        passCtrl.text.trim(),
                      );
                      if (loginOk) {
                        //
                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        mostrarAlerta(
                          context,
                          'Login Incorrecto',
                          'Revise sus datos de ingreso nuevamente',
                        );
                      }
                    },
          ),
        ],
      ),
    );
  }
}
