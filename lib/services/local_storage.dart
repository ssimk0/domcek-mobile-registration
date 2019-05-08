import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:domcek_registration_mobile/model/participant.dart';
import 'storage.dart';

class LocalStorage implements Storage {
  Map<String,List<dynamic>> _data = {};

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

  parseDataFromString(String jsonString, {String dataAlias = null, shouldSave=true}) {
    var data = json.decode(jsonString);

    if (dataAlias != null) {
      this._data[dataAlias] = data;
    } else {
      this._data = data;
    }

    if (shouldSave) {
      this._save(json.encode(this._data));
    }

    return data;
  }

  _save(data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    await file.writeAsString(data);
  }

  @override
  Map<String, List<dynamic>> get data {
    return Map.from(this._data);
  }
}