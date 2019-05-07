class Participant {
  final int userId;
  final String firstName;
  final String groupName;
  final String paymentNumber;
  final String note;
  final int paid;
  final int needPay;
  final int onRegistration;
  final String volunteerType;
  final bool wasOnEvent;
  final dynamic transportIn;
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

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      userId: json['user_id'],
      paymentNumber: json['payment_number'].toString(),
      firstName: json['first_name'],
      note: json['note'],
      needPay: json['need_pay'],
      paid: json['paid'],
      volunteerType: json['volunteer_type_id'].toString(),
      groupName: json['group_name'],
      onRegistration: json['on_registration'],
      wasOnEvent: json['was_on_event'] == 1,
      transportIn: json['transport_in'],
      transportOut: json['transport_out'],
    );
  }
}