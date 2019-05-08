import 'package:domcek_registration_mobile/pages/upload_data_page.dart';
import 'package:flutter/material.dart';

class UploadDataButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadDataPage()),
            );
          },
          child: Text('Nahrat data na server')),
    );
  }
}