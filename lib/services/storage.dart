abstract class Storage {

  Map<String, List<dynamic>> parseDataFromString(String jsonString, { String dataAlias = null, shouldSave = true});

  Map<String,List<dynamic>> get data;

  Future<void> init() async {}

  Future<void> clear() async {}
}