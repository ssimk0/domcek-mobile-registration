import 'package:json_annotation/json_annotation.dart';

part 'participant.g.dart';



@JsonSerializable()
class Participant {
  static stringify(value) {
    return value != null ? value.toString() : null;
  }

  static intify(value) {
    return int != null ? int.tryParse(value) : null;
  }

  static intToBool(value) {
    return value != null ? value > 0 : false;
  }

  static boolToInt(value) {
    return value ? 1 : 0;
  }

  @JsonKey(name: 'user_id', nullable: true)
  final int userId;
  @JsonKey(name: 'first_name', nullable: true)
  final String firstName;
  @JsonKey(name: 'group_name', toJson: intify, fromJson: stringify, nullable: true)
  final String groupName;
  @JsonKey(name: 'payment_number', toJson: intify, fromJson: stringify, nullable: true)
  final String paymentNumber;
  @JsonKey(name: 'note', nullable: true)
  final String note;
  @JsonKey(name: 'paid', nullable: true)
  final int paid;
  @JsonKey(name: 'birth_date', nullable: true)
  final String birthDate;
  @JsonKey(name: 'need_pay', nullable: true)
  final int needPay;
  @JsonKey(name: 'on_registration', nullable: true)
  int onRegistration;
  @JsonKey(name: 'name', nullable: true)
  final String volunteerType;
  @JsonKey(name: 'was_on_event', toJson: boolToInt, fromJson: intToBool, nullable: true)
  bool wasOnEvent;
  @JsonKey(name: 'admin_note', nullable: true)
  final String adminNote;
  @JsonKey(name: 'transport_in', nullable: true)
  final dynamic transportIn;
  @JsonKey(name: 'transport_out', nullable: true)
  dynamic transportOut;

  Participant({
    this.userId,
    this.paymentNumber,
    this.firstName,
    this.paid,
    this.birthDate,
    this.note,
    this.needPay,
    this.volunteerType,
    this.groupName,
    this.onRegistration,
    this.wasOnEvent,
    this.adminNote,
    this.transportIn,
    this.transportOut
  });

  register(int amount, bool bus) {
    this.onRegistration = amount;
    this.wasOnEvent = true;
    this.transportOut = '11:00';
  }

  haveBusIn() {
    return this.transportIn is String && this.transportIn.contains(':');
  }

  haveBusOut() {
    return this.transportOut is String && this.transportOut.contains(':');
  }

  int get needPayOnRegistration {
    var amount = this.needPay - this.paid - (this.onRegistration != null ? this.onRegistration : 0);
    return amount < 0 ? 0 : amount;
  }

  factory Participant.fromJson(Map<String, dynamic> json) => _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}