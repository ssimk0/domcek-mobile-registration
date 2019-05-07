import 'package:domcek_registration_mobile/services/registration_data.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FetchData extends StatefulWidget {
  RegistrationData _registration_data;

  Storage storage;

  FetchData(Storage storage) {
    this._registration_data = RegistrationData(storage);
    this.storage = storage;
  }

  @override
  FetchDataState createState() {
    return FetchDataState(_registration_data, storage);
  }
}

class FetchDataState extends State<FetchData> {
  final _formKey = GlobalKey<FormState>();
  final tokenController = TextEditingController();

  RegistrationData registration_data;
  Storage storage;

  FetchDataState(RegistrationData this.registration_data, Storage this.storage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Code Scanner & Generator'),
      ),
      body: Center(
          child:
          Form(
            key: _formKey,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child:
                      TextFormField(
                        controller: tokenController,
                        decoration: InputDecoration(
                            labelText: 'Enter your token'
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                        },
                    )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await this.registration_data.fetchData(tokenController.text);
                          Navigator.pop(
                              context
                          );
                        }
                      },
                      child: const Text('Downaload Data')
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}