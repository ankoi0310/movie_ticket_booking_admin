class Seat {
  String id;
  String position;
  int columnIndex;
  int rowIndex;
  String state;
  String createdAt;
  String updatedAt;

  Seat({
    required this.id,
    required this.position,
    required this.columnIndex,
    required this.rowIndex,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  Seat.withoutId({
    required this.position,
    required this.columnIndex,
    required this.rowIndex,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  }) : id = '';

  Seat.empty()
      : id = '',
        position = '',
        columnIndex = 0,
        rowIndex = 0,
        state = '',
        createdAt = '',
        updatedAt = '';

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      position: json['position'],
      columnIndex: json['columnIndex'],
      rowIndex: json['rowIndex'],
      state: json['state'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
      'columnIndex': columnIndex,
      'rowIndex': rowIndex,
      'state': state,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
