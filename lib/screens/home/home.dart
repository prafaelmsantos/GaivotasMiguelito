import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/map.dart';
import 'package:flutter_app/screens/home/review.dart';
import 'package:flutter_app/screens/profile/editProfile.dart';
import 'package:flutter_app/services/firestoreUsers.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _userEmail = FirebaseAuth.instance.currentUser.email;
  String _userName = FirebaseAuth.instance.currentUser.displayName;

  String _dateCreation = DateFormat('yyyy-MM-dd – kk:mm').format(FirebaseAuth.instance.currentUser.metadata.creationTime);
  String _dateLastSigned = DateFormat('yyyy-MM-dd – kk:mm').format(FirebaseAuth.instance.currentUser.metadata.lastSignInTime);




  Future<void> _logoutuser() async {

    //Firestore offline
    OfflineUser();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/welcome');

  }


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
            Text('Criado a '+_dateCreation),
            Text('Ultimo login '+_dateLastSigned),
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
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Reviews'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Review()));
                print('Review');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              subtitle: Text('Finalizar sessão'),
              onTap: () async {
                print('Sair');
                _logoutuser();

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