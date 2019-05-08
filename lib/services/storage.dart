
import 'package:domcek_registration_mobile/model/participant.dart';

abstract class Storage {
  Map<String,List<dynamic>> _data = {};

  List<dynamic> parseDataFromString(String jsonString, { String dataAlias = null, shouldSave = true});

  Map<String,List<dynamic>> get data;
}