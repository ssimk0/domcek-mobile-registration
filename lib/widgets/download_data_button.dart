import 'package:domcek_registration_mobile/pages/download_data_page.dart';
import 'package:flutter/material.dart';

class DownloadDataButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DownloadDataPage()),
            );
          },
          child: Text('Stiahnuť data zo servera')),
    );
  }
}