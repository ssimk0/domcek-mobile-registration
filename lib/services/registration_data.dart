import 'package:http/http.dart' as http;
import 'package:domcek_registration_mobile/services/storage.dart';

class RegistrationData {

  Storage _storage;

  RegistrationData(this._storage);

  fetchData(token) async {
    final response = await http.get('https://api.domcek.org/api/registration/events/103/participants/sync?token=' + token);
    if (response.statusCode == 200) {
      return this._storage.parseDataFromString(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

}