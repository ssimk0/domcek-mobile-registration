import 'package:domcek_registration_mobile/services/local_storage.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:domcek_registration_mobile/home_screen.dart';

void main() => runApp(MyApp(LocalStorage()));

class MyApp extends StatelessWidget {
  LocalStorage _storage;

  MyApp(Storage storage) {
    this._storage = storage;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Generator-Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(this._storage),
    );
  }
}