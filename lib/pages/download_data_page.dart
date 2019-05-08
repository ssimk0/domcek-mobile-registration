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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _error != '' && _error != null ? Text(_error, style: TextStyle(color: Colors.red)) : Text(''),
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: TextFormField(
                      controller: tokenController,
                      decoration:
                          InputDecoration(labelText: 'Zadaj svoj token'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Token musí byť vyplnení';
                        }
                      },
                    )),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: () async {
                        print('here');
                        if (_formKey.currentState.validate()) {
                          try {
                            print('fetching');
                            await model
                                .fetchParticipants(tokenController.text);
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                           _error = 'Nepodarilo sa stiahnuť data, skus znova alebo kontaktuj niekoho s registracie';
                          }
                        }
                      },
                      child: const Text('Stiahnuť Data')),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
