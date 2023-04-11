class Seat {
  // seat in the cinema
  final String id;
  final String code;
  final String roomId;
  final String status;

  Seat({
    required this.id,
    required this.code,
    required this.roomId,
    required this.status,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      code: json['code'],
      roomId: json['roomId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'roomId': roomId,
      'status': status,
    };
  }
}
