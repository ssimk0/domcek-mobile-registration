import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:domcek_registration_mobile/pages/ParticipantDetailPage.dart';
import 'package:flutter/services.dart';
import 'package:domcek_registration_mobile/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Scan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScanState();
  }
}

class ScanState extends State<Scan> {
  String barcode;
  String error;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              error != '' && error != null
                  ? Text(error, style: TextStyle(color: Colors.red))
                  : Text('')
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: () => scan(model),
                    child: const Text('Naskenovať QR')),
              ))
        ],
      );
    });
  }

  Future scan(MainModel model) async {
    try {
      if (model.hasParticipantData()) {
        String barcode = await BarcodeScanner.scan();
        var decoded = base64.decode(barcode);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ParticipantDetailPage(
                  model.findByPaymentNumber(utf8.decode(decoded)))),
        );
      } else {
        setState(() => this.error = 'Najprv musíš stiahnuť data');
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.error =
              'Nemáš povolenie použivať kameru v aplikácii, to si zmeň v nastaveniach telefónu!';
        });
      } else {
        setState(() => this.error = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.error =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.error = 'Unknown error: $e');
    }
  }
}
