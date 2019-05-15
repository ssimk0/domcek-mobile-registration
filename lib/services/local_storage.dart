import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'storage.dart';

class LocalStorage implements Storage {
  Map<String,List<dynamic>> _data = {};

  LocalStorage() {
    this._read();
  }

  init() async {
    return this._read();
  }

  Future<void> _read() async {
    try {
      final directory = await _localPath;
      final file = File('$directory/data.json');

      if (file.existsSync()) {
        String text = await file.readAsString();
        this.parseDataFromString(text, shouldSave: false);
      }
    } catch (e) {
      print("Couldn't read file : " + e.toString());
    }
  }

  parseDataFromString(String jsonString, {String dataAlias = null, shouldSave=true}) {

    var data = json.decode(jsonString);

    if (dataAlias != null) {
      this._data[dataAlias] = data;
    } else {
      data.forEach((key, data) {
        var list = List<dynamic>.from(data);
        this._data[key] = list;
      });
    }

    if (shouldSave) {
      this._save(json.encode(this._data));
    }

    return _data;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  _save(data) async {
    final directory = await _localPath;
    final file = File('$directory/data.json');
    await file.writeAsString(data);
  }

  @override
  Map<String, List<dynamic>> get data {
    return Map.from(this._data);
  }

  @override
  clear() async {
    try {
      final directory = await _localPath;
      final file = File('$directory/data.json');
      await file.delete();
      this._data = {};
    } catch (e) {
      print("Couldn't delete file : " + e.toString());
    }
  }
}