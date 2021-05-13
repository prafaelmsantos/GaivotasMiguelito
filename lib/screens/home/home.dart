import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/map.dart';
import 'package:flutter_app/screens/profile/edit_profile.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _userEmail = FirebaseAuth.instance.currentUser.email;
  String _userName = FirebaseAuth.instance.currentUser.displayName;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_userName),
              accountEmail: Text(_userEmail),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: (){
                print('home');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Minha conta'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsUI()));
                print('Conta');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              subtitle: Text('Finalizar sessão'),
              onTap: () async {
                print('Sair');

                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/welcome');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Gaivotas Miguelito'),
      ),
      body: MapPage(),
    );
  }
}