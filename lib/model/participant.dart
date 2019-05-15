import 'package:json_annotation/json_annotation.dart';

part 'participant.g.dart';



@JsonSerializable()
class Participant {
  static stringify(value) {
    return value.toString();
  }

  static intify(value) {
    return int.tryParse(value);
  }

  static intToBool(value) {
    return value > 0;
  }

  static boolToInt(value) {
    return value ? 1 : 0;
  }

  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'group_name')
  final String groupName;
  @JsonKey(name: 'payment_number', toJson: intify, fromJson: stringify)
  final String paymentNumber;
  final String note;
  final int paid;
  @JsonKey(name: 'need_pay')
  final int needPay;
  @JsonKey(name: 'on_registration')
  int onRegistration;
  @JsonKey(name: 'name')
  final String volunteerType;
  @JsonKey(name: 'was_on_event', toJson: boolToInt, fromJson: intToBool)
  bool wasOnEvent;
  @JsonKey(name: 'transport_in')
  final dynamic transportIn;
  @JsonKey(name: 'transport_out')
  final dynamic transportOut;

  Participant({
    this.userId,
    this.paymentNumber,
    this.firstName,
    this.paid,
    this.note,
    this.needPay,
    this.volunteerType,
    this.groupName,
    this.onRegistration,
    this.wasOnEvent,
    this.transportIn,
    this.transportOut
  });

  register(int amount) {
    this.onRegistration = amount;
    this.wasOnEvent = true;
  }

  int get needPayOnRegistration {
    var amount = this.needPay - this.paid - (this.onRegistration != null ? this.onRegistration : 0);
    return amount < 0 ? 0 : amount;
  }

  factory Participant.fromJson(Map<String, dynamic> json) => _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}