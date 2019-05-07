
import 'package:domcek_registration_mobile/model/participant.dart';

abstract class Storage {
  List<Participant> data = [];

  parseDataFromString(String jsonString, {shouldSave = true});

  Participant findByPaymentNumber(String paymentNumber);

  bool isEmpty();
}