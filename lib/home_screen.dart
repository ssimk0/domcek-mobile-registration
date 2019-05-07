import 'dart:convert';

import 'package:domcek_registration_mobile/SyncDataActions.dart';
import 'package:domcek_registration_mobile/participant_detail.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen(Storage storage){
    this.storage = storage;
  }

  Storage storage;

  @override
  _HomeScreenState createState() => new _HomeScreenState(this.storage);
}

class _HomeScreenState extends State<HomeScreen> {
    String barcode = "";
  var error;
  Storage storage;

  _HomeScreenState(Storage storage) {
    this.storage = storage;
  }

  @override
  initState() {
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Code Scanner & Generator'),
      ),
      body: Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('SCAN QR CODE')
                ),
              ),
              this.error != null ? Text(this.error) : Text(''),
              SyncDataActions(this.storage)
            ],
          )
      ),
    );
  }

  Future scan() async {
    try {
      if (this.storage.isEmpty()) {
        setState(() => this.error = 'Please first download a data');
      } else {
        String barcode = await BarcodeScanner.scan();
        var decoded = base64.decode(barcode);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ParticipantDetail(this.storage.findByPaymentNumber(utf8.decode(decoded)))
          ),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}