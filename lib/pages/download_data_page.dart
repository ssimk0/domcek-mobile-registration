import 'package:domcek_registration_mobile/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

class DownloadDataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DownloadDataPageState();
  }
}

class DownloadDataPageState extends State<DownloadDataPage> {
  final _formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();
  String _error;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Stiahnuť data'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _error != '' && _error != null
                      ? Text(_error, style: TextStyle(color: Colors.red))
                      : Text(''),
                  TextFormField(
                    controller: tokenController,
                    decoration: InputDecoration(labelText: 'Zadaj svoj token'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Token musí byť vyplnení';
                      }
                    },
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            await model.fetchParticipants(tokenController.text);
                            tokenController.clear();
                            Navigator.pop(context);
                          } catch (e) {
                            _error =
                                'Nepodarilo sa stiahnuť data, skus znova alebo kontaktuj niekoho s registracie';
                          }
                        }
                      },
                      child: const Text('Stiahnuť Data')),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
