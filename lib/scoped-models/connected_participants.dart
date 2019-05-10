import 'package:domcek_registration_mobile/model/participant.dart';
import 'package:domcek_registration_mobile/services/local_storage.dart';
import 'package:domcek_registration_mobile/services/storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;


const String PARTICIPANT_ALIAS = 'participants';

mixin ConnectedParticipantModel on Model {

  List<Participant> _participants = [];
  Storage _storage;
 // bool _isLoading = true;

  init() {
    this._storage = LocalStorage();
    this._participants = this._storage.data[PARTICIPANT_ALIAS];
    notifyListeners();
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
    final response = await http.get('https://api.domcek.org/api/registration/events/participants/sync?token=' + token);
    if (response.statusCode == 200) {
      _participants = [];
      var data = _storage.parseDataFromString(response.body, dataAlias: PARTICIPANT_ALIAS);
      data.forEach((item) => _participants.add(Participant.fromJson(item)));
      notifyListeners();
      return;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> syncParticipants(String token) async {

  }

  bool hasParticipantData() {
    return _participants != null && _participants.length > 0;
  }
}
