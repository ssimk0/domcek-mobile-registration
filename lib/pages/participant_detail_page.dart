import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:domcek_registration_mobile/widgets/register_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ParticipantDetailPage extends StatelessWidget {
  final Participant participant;

  ParticipantDetailPage(this.participant);

  @override
  Widget build(BuildContext context) {
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
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
        child: ListView(children: <Widget>[
          Text('Nebol najdeny'),
          RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              splashColor: Colors.blueGrey,
              onPressed: (() => Navigator.pop(context)),
              child: const Text('Back')),
        ]));
  }

  Widget getParticipant(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text(
                'Meno: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(this.participant.firstName)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Variabilný symbol: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.participant.paymentNumber)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Zaplatil: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.participant.paid.toString())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Potrebuje doplatiť: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(participant.needPayOnRegistration.toString())
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Dobrovolnik: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.participant.volunteerType != null &&
                      this.participant.volunteerType != ''
                  ? this.participant.volunteerType
                  : 'Nie')
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Skupinka: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(this.participant.groupName != null
                  ? this.participant.groupName
                  : '')
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Text('Poznamka: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                  child: Html(
                      data: this.participant.note != null
                          ? this.participant.note
                          : '')),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
               Text(
               DateTime.now().year - DateTime.tryParse(this.participant.birthDate).year < 18 ? 'Skontroluj potvrdenie od rodicov' : '',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        participant.wasOnEvent
            ? Center(
                child: Text(
                'Už bol registrovaný',
                style: TextStyle(color: Colors.green),
              ))
            : RegisterAction(this.participant)
      ]),
    );
  }
}
