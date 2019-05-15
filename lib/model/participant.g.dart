// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) {
  return Participant(
      userId: json['user_id'] as int,
      paymentNumber: json['payment_number'] == null
          ? null
          : Participant.stringify(json['payment_number']),
      firstName: json['first_name'] as String,
      paid: json['paid'] as int,
      note: json['note'] as String,
      needPay: json['need_pay'] as int,
      volunteerType: json['name'] as String,
      groupName: json['group_name'] as String,
      onRegistration: json['on_registration'] as int,
      wasOnEvent: json['was_on_event'] == null
          ? null
          : Participant.intToBool(json['was_on_event']),
      transportIn: json['transport_in'],
      transportOut: json['transport_out']);
}

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'group_name': instance.groupName,
      'payment_number': instance.paymentNumber == null
          ? null
          : Participant.intify(instance.paymentNumber),
      'note': instance.note,
      'paid': instance.paid,
      'need_pay': instance.needPay,
      'on_registration': instance.onRegistration,
      'name': instance.volunteerType,
      'was_on_event': instance.wasOnEvent == null
          ? null
          : Participant.boolToInt(instance.wasOnEvent),
      'transport_in': instance.transportIn,
      'transport_out': instance.transportOut
    };
