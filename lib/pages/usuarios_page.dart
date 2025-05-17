import 'package:flutter/material.dart';

import 'package:chat_app/models/usuario.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );
  final usuarios = [
    Usuario(uid: '1', nombre: 'Maria', email: 'test1@test.com', online: true),
    Usuario(
      uid: '2',
      nombre: 'Melissa',
      email: 'test2@test.com',
      online: false,
    ),
    Usuario(uid: '3', nombre: 'Juan', email: 'test3@test.com', online: true),
    Usuario(uid: '4', nombre: 'Mechas', email: 'test4@test.com', online: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Mi nombre',
            style: TextStyle(
              color: Colors.amber.shade100,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),

        elevation: 3,
        backgroundColor: Colors.brown.shade200,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.amber.shade100,
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 18),
            child: Icon(Icons.check_circle_sharp, color: Colors.green.shade800),
            //child: Icon(Icons.offline_bolt_rounded, color: Colors.red.shade800),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check_circle, color: Colors.lightGreen.shade400),
          waterDropColor: Colors.lightGreen.shade200,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.amber.shade100,
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green.shade600 : Colors.red.shade800,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
