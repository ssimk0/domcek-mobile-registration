import 'package:domcek_registration_mobile/fetch_data.dart';
import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:flutter/material.dart';

class SyncDataActions extends StatefulWidget {

  List<Participant> data = [];

  Storage storage;

  SyncDataActions(storage) {
    this.storage = storage;
  }

  @override
  SyncDataActionsState createState() => new SyncDataActionsState(this.storage);

}

class SyncDataActionsState extends State<SyncDataActions> {
  var storage;

  SyncDataActionsState(storage) {
    this.storage = storage;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: () {
            print(this.storage.data);
            if (this.storage.data.length == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FetchData(this.storage)
                ),
              );
            } else {
              print('Upload');
            }
          },
          child: Text(this.storage.data.length == 0 ? 'Download Data' : 'Upload Data')
      ),
    );
  }
}