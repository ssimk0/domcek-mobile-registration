import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ParticipantDetail extends StatelessWidget {
  final Participant participant;

  ParticipantDetail(this.participant);

  @override
  Widget build(BuildContext context) {
    print(this.participant);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ucastnik'),
      ),
      body: Center(
          child: this.participant != null
              ? this.getParticipant(context)
              : this.notFound(context)),
    );
  }

  Widget notFound(BuildContext context) {
    return ListView(children: <Widget>[
      Text('Nebol najdeny'),
      RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          splashColor: Colors.blueGrey,
          onPressed: (() => Navigator.pop(context)),
          child: const Text('Back')),
    ]);
  }

  Widget getParticipant(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView(children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Meno: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(this.participant.firstName)
          ],
        ),
        Row(
          children: <Widget>[
            Text('PaymentNumber: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.participant.paymentNumber)
          ],
        ),
        Row(
          children: <Widget>[
            Text('Zaplatil: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.participant.paid.toString())
          ],
        ),
        Row(
          children: <Widget>[
            Text('Potrebuje doplatiť: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.participant.needPay.toString())
          ],
        ),
        Row(
          children: <Widget>[
            Text('Dobrovolnik: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.participant.volunteerType != null &&
                    this.participant.volunteerType != ''
                ? this.participant.volunteerType
                : 'Nie')
          ],
        ),
        Row(
          children: <Widget>[
            Text('Skupinka: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(this.participant.groupName != null
                ? this.participant.groupName
                : '')
          ],
        ),
        Row(
          children: <Widget>[
            Text('Poznamka: ', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
                child: Html(
                    data: this.participant.note != null
                        ? this.participant.note
                        : '')),
          ],
        ),
        RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            splashColor: Colors.blueGrey,
            onPressed: (() => {
                  // register it
                }),
            child: const Text('Register')),
      ]),
    );
  }
}
