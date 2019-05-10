abstract class Storage {

  List<dynamic> parseDataFromString(String jsonString, { String dataAlias = null, shouldSave = true});

  Map<String,List<dynamic>> get data;
}