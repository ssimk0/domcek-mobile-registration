import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:domcek_registration_mobile/model/participant.dart';
import 'storage.dart';

class LocalStorage implements Storage {
  List<Participant> data = [];

  LocalStorage() {
    this._read();
  }

  Future<void> _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.json');
      if (file.existsSync()) {
        String text = await file.readAsString();
        this.parseDataFromString(text, shouldSave: false);
      }
    } catch (e) {
      print("Couldn't read file");
    }
  }

  parseDataFromString(String jsonString, {shouldSave=true}) {
    List<Participant> participants = [];
    this.data = [];

    List<dynamic> data = json.decode(jsonString);
    data.forEach((item) => participants.add(Participant.fromJson(item)));

    this.data = participants;

    if (shouldSave) {
      this._save(jsonString);
    }
  }

  Participant findByPaymentNumber(String paymentNumber) {
     var data = this.data.where((participant) {
        print(participant.paymentNumber);
        return participant.paymentNumber == paymentNumber;
     });
     print(paymentNumber);
     return data.length > 0 ? data.first : null;
  }

  _save(data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    await file.writeAsString(data);
  }

  @override
  bool isEmpty() {
    return this.data.length == 0;
  }
}