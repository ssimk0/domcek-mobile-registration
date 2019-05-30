import 'dart:convert';

import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:domcek_registration_mobile/services/local_storage.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

const String PARTICIPANT_ALIAS = 'participants';

mixin ConnectedParticipantModel on Model {
  String api = 'api.domcek.org';
  List<Participant> _participants = [];
  bool loading = false;
  Storage _storage;

  // bool _isLoading = true;

  init() async {
    loading = true;
    _storage = LocalStorage();
    await _storage.init();

    if (_storage.data[PARTICIPANT_ALIAS] != null) {
      var list = _storage.data[PARTICIPANT_ALIAS];
      list.forEach((item) => _participants.add(Participant.fromJson(item)));
    }

    loading = false;
    notifyListeners();
  }

  void saveData() {
    this._storage.parseDataFromString(json.encode(this._participants),
        shouldSave: true, dataAlias: PARTICIPANT_ALIAS);
  }
}

mixin ParticipantModel on ConnectedParticipantModel {
  Participant findByPaymentNumber(String paymentNumber) {
    var data = this._participants.where((participant) {
      return participant.paymentNumber == paymentNumber;
    });
    return data.length > 0 ? data.first : null;
  }

  Future<void> fetchParticipants(String token) async {
    final response = await http.get(
        'https://$api/api/registration/events/participants/sync?token=$token');
    if (response.statusCode == 200) {
      _participants = [];
      var data = _storage.parseDataFromString(response.body,
          dataAlias: PARTICIPANT_ALIAS);
      data[PARTICIPANT_ALIAS]
          .forEach((item) => _participants.add(Participant.fromJson(item)));
      notifyListeners();
      return;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to download post');
    }
  }

  Future<void> syncParticipants(String token) async {
    var encodedData = jsonEncode(_storage.data);
    final backup = await http.post(
        Uri.encodeFull('https://$api/api/registration/backup?token=$token'),
        body: encodedData,
        headers: {"Content-Type": "application/json"});

    if (backup.statusCode == 201) {
      final response = await http.put(
          Uri.encodeFull(
              'https://$api/api/registration/events/participants/sync?token=$token'),
          body: encodedData,
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        await this._storage.clear();
        _participants = null;
        notifyListeners();
        return;
      }
    }

    throw Exception('Failed to upload data');

  }

  bool hasParticipantData() {
    return _participants != null && _participants.length > 0;
  }
}
