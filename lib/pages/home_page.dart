import 'package:domcek_registration_mobile/scoped-models/main.dart';
import 'package:domcek_registration_mobile/widgets/Scan.dart';
import 'package:domcek_registration_mobile/widgets/download_data_button.dart';
import 'package:domcek_registration_mobile/widgets/upload_data_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class HomePage extends StatelessWidget {
  MainModel _model;

  HomePage(this._model);

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
              Scan(),
              this._model.hasParticipantData() ? UploadDataButton() : DownloadDataButton()
            ],
          )
      ),
    );
  }


}