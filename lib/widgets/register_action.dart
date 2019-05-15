import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:domcek_registration_mobile/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterAction extends StatefulWidget {
  Participant participant;

  RegisterAction(this.participant);

  @override
  State<StatefulWidget> createState() {
    return _RegisterActionState();
  }
}

class _RegisterActionState extends State<RegisterAction> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  String _error;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Center(
          child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _error != '' && _error != null
                        ? Text(_error, style: TextStyle(color: Colors.red))
                        : Text(''),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          decoration: InputDecoration(labelText: 'Zadaj sumu'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Suma musí byť vyplnená';
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
                          onPressed: (() {
                            var paid = int.tryParse(this.amountController.text, radix: 10);
                            this.widget.participant.register(paid);
                            model.saveData();
                            Navigator.pop(context);
                          }),
                          child: const Text('Registrovať')),
                    )
                  ])));
    });
  }
}
